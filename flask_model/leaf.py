import os
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '0'
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"
from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import cv2
from flask_cors import CORS

# Inisialisasi Flask
app = Flask(__name__)
CORS(app)

# Muat model TensorFlow yang sudah dilatih
MODEL_PATH = 'model/model_daun.keras'  # Path ke model
model = tf.keras.models.load_model(MODEL_PATH)


class LeafPredictor:
    def __init__(self, model):
        """Inisialisasi predictor dengan model."""
        self.model = model
        self.img_size = 128  # Ukuran gambar
        self.categories = ['Non-Daun', 'Daun']

    def preprocess_image(self, img):
        """Preprocessing gambar untuk model."""
        if len(img.shape) == 2:
            img = cv2.cvtColor(img, cv2.COLOR_GRAY2RGB)
        elif img.shape[2] == 4:
            img = cv2.cvtColor(img, cv2.COLOR_BGRA2RGB)
        elif img.shape[2] == 3:
            img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        img = cv2.resize(img, (self.img_size, self.img_size))
        img = img / 255.0  # Normalisasi
        img = np.expand_dims(img, axis=0)  # Tambahkan dimensi batch
        return img

    def predict(self, img_path):
        """Lakukan prediksi gambar."""
        img = cv2.imread(img_path)
        if img is None:
            raise ValueError("Gagal membaca gambar, pastikan path benar!")

        processed_img = self.preprocess_image(img)
        predictions = self.model.predict(processed_img)
        predicted_class = np.argmax(predictions[0])
        confidence = predictions[0][predicted_class]

        return {
            'predicted_class': self.categories[predicted_class],
            'confidence': confidence
        }


# Inisialisasi objek predictor
predictor = LeafPredictor(model)


# Flask Route: Prediksi Gambar
@app.route('/predict', methods=['POST'])
def predict():
    """
    Endpoint untuk prediksi gambar.
    Mengharapkan file gambar sebagai input.
    """
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'Empty file name'}), 400

    # Simpan file temporer
    file_path = os.path.join('temp_image.jpg')
    file.save(file_path)

    try:
        # Lakukan prediksi
        result = predictor.predict(file_path)
        os.remove(file_path)  # Hapus file setelah prediksi selesai

        # Format respons
        response = {
            'predicted_class': result['predicted_class'],
            'confidence': f"{result['confidence']*100:.2f}%"
        }
        return jsonify(response)

    except Exception as e:
        return jsonify({'error': str(e)}), 500


# Flask Route: Cek Status
@app.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'Flask API for Leaf Prediction is running!'})


# Menjalankan Flask
if __name__ == '__main__':
    port = 5001  # Ubah port di sini jika diperlukan
    app.run(debug=True, port=port)
