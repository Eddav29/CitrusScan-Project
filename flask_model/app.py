import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"
from flask import Flask, request, jsonify
from flask_cors import CORS
import tensorflow as tf
import cv2
import numpy as np
import json
from werkzeug.utils import secure_filename

app = Flask(__name__)
CORS(app)

# Configuration
UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}
MODEL_PATH = "model/citrus_disease_model.keras"
CATEGORIES = ['Black spot', 'Melanose', 'Canker', 'Greening', 'Healthy']

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def preprocess_image(img, target_size=224):
    try:
        # Convert to RGB if needed
        if len(img.shape) == 2:
            img = cv2.cvtColor(img, cv2.COLOR_GRAY2RGB)
        elif img.shape[2] == 4:
            img = cv2.cvtColor(img, cv2.COLOR_BGRA2RGB)
        elif img.shape[2] == 3:
            img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        # Maintain aspect ratio while resizing
        h, w = img.shape[:2]
        scale = target_size / max(h, w)
        new_h, new_w = int(h * scale), int(w * scale)
        img = cv2.resize(img, (new_w, new_h), interpolation=cv2.INTER_LANCZOS4)

        # Create square image with padding
        square_img = np.zeros((target_size, target_size, 3), dtype=np.uint8)
        y_offset = (target_size - new_h) // 2
        x_offset = (target_size - new_w) // 2
        square_img[y_offset:y_offset+new_h, x_offset:x_offset+new_w] = img

        # Enhance contrast
        lab = cv2.cvtColor(square_img, cv2.COLOR_RGB2LAB)
        l, a, b = cv2.split(lab)
        clahe = cv2.createCLAHE(clipLimit=3.0, tileGridSize=(8,8))
        l_clahe = clahe.apply(l)
        lab = cv2.merge([l_clahe, a, b])
        img = cv2.cvtColor(lab, cv2.COLOR_LAB2RGB)

        # Normalize
        img = tf.keras.applications.efficientnet.preprocess_input(img)
        return img
    except Exception as e:
        raise Exception(f"Error in image preprocessing: {str(e)}")

# Load model at startup
try:
    model = tf.keras.models.load_model(MODEL_PATH)
except Exception as e:
    print(f"Error loading model: {str(e)}")
    model = None

@app.route('/predict', methods=['POST'])
def predict():
    try:
        if 'file' not in request.files:
            return jsonify({
                'success': False,
                'error': 'No file provided'
            }), 400
        
        file = request.files['file']
        if file.filename == '':
            return jsonify({
                'success': False,
                'error': 'No file selected'
            }), 400
            
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            
            try:
                file.save(filepath)
                img = cv2.imread(filepath)
                if img is None:
                    return jsonify({
                        'success': False,
                        'error': 'Invalid image file'
                    }), 400

                processed_img = preprocess_image(img)
                prediction = model.predict(np.expand_dims(processed_img, axis=0))[0]
                predicted_class = np.argmax(prediction)
                confidence = float(prediction[predicted_class])

                result = {
                    'success': True,
                    'predictions': {
                        'predicted_class': CATEGORIES[predicted_class],
                        'confidence': confidence,
                        'all_probabilities': {
                            category: float(prob) 
                            for category, prob in zip(CATEGORIES, prediction)
                        }
                    }
                }
                
                os.remove(filepath)
                return jsonify(result)
                
            except Exception as e:
                if os.path.exists(filepath):
                    os.remove(filepath)
                return jsonify({
                    'success': False,
                    'error': str(e)
                }), 500
                
        return jsonify({
            'success': False,
            'error': 'Invalid file type'
        }), 400
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)