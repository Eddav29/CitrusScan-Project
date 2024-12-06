import requests
import os
import json

def load_categories():
    """Load categories from model metadata file"""
    try:
        with open('model/citrus_disease_model_metadata.json', 'r') as f:
            metadata = json.load(f)
            return metadata.get('categories', [])
    except Exception as e:
        print(f"Error loading categories: {str(e)}")
        return []

def test_prediction(image_path):
    """Test prediction endpoint with an image file"""
    url = 'http://localhost:5000/predict'
    
    try:
        if not os.path.exists(image_path):
            raise FileNotFoundError(f"Image not found: {image_path}")
            
        with open(image_path, 'rb') as image_file:
            files = {'file': image_file}
            response = requests.post(url, files=files)
            
        print(f'Image: {os.path.basename(image_path)}')
        print('Status Code:', response.status_code)
        
        if response.status_code == 200:
            result = response.json()
            predictions = result.get('predictions', {})
            print('Prediction:', predictions.get('predicted_class'))
            print('Confidence:', f"{predictions.get('confidence', 0):.2%}")
            print('All Probabilities:')
            for disease, prob in predictions.get('all_probabilities', {}).items():
                print(f"  {disease}: {prob:.2%}")
        else:
            print('Error:', response.json().get('error', 'Unknown error'))
            
        print('-' * 50)
        
    except FileNotFoundError as e:
        print(f"Error: {str(e)}")
    except Exception as e:
        print(f"Error testing {image_path}: {str(e)}")

if __name__ == '__main__':
    # Load categories from metadata
    categories = load_categories()
    if not categories:
        print("Error: Could not load categories from metadata")
        exit(1)
    
    # Directory containing test images
    image_dir = 'test_images'
    os.makedirs(image_dir, exist_ok=True)
    
    # List of test images matching categories
    test_images = [
        'black_spot.png',  # Image for Black spot
        'melanose.jpg',    # Image for Melanose
        'canker.png',      # Image for Canker
        'greening.png',    # Image for Greening
        'healthy.png'      # Image for Healthy
    ]
    
    print("Testing prediction API with images...")
    print(f"Using categories: {', '.join(categories)}")
    
    # Test each image
    for image_name in test_images:
        image_path = os.path.join(image_dir, image_name)
        test_prediction(image_path)