# Biruwa
Biruwa is a mobile application that uses image classification techniques to predict plant diseases. It utilizes a transfer learning approach with ResNet50 to analyze grapevine leaf images and make predictions based on a trained dataset. This model helps users diagnose plant health issues efficiently.

## Features
- Predicts plant diseases from grapevine leaf images.
- Simple and user-friendly interface.

## Technologies Used
- Flutter for mobile app development
- Flask For Hosting A Simple ML Model And For Fetching Recommendations
- TensorFlow and ResNet50 for machine learning.
## Setup Instructions

1. Clone The Repository
```bash
git clone https://github.com/AshitomW/Biruwa.git
```

### For Server

1. Navigate to ml directory
```bash
cd ml
```
2. Install Required Dependencies  
  ```bash
  pip install -r requirements.txt
  ```
3. Train The Machine Learning Model With Help of Prediction.ipynb
4. Save The Model In h5 Format and ClassLists/Labels in Json Format
5. Set Up .env File To Load Google Gemini For Getting Recommendations
```env
API_KEY = ""
GEN_MODEL = "gemini-1.5-flash"
```
6. Run The Server
```bash
python app.py
```



### For Mobile Application

1. Navigate to application directory
```bash
cd application
```
2. Install Flutter Dependencies
```bash
flutter pub get
```
3. Set The Ip Address Of The Server Hosting Model In requests.dart
```dart
final url = Uri.parse("[ip_address]/predict");
```
4. Run The App
```dart
flutter run
```

## Contributing

Feel free to fork the repository and submit pull requests for any improvements or bug fixes.


