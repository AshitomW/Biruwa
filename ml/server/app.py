from flask import Flask, request, jsonify
import numpy as np
from tensorflow.keras.models import  load_model
from tensorflow.keras.preprocessing.image import img_to_array, load_img
from PIL import Image
import json
from getDetails import MakeRequest


def LabelParse(label):
   name, diagnosis=  label.split("_")
   result = {"name":name, "diagnosis":diagnosis}
   return result




model = load_model("model.h5")
IMAGE_SIZE = (180,180)
app = Flask(__name__)

@app.route("/predict",methods=["POST"])
def predict():
    if "file" not in request.files:
        return jsonify({"error" : "No File Part"})
    
    file = request.files["file"]
    if file.filename == "":
        return jsonify({"error" : "No selected file"})
    


    try:
        image = Image.open(file)
        image = image.resize(IMAGE_SIZE)
        image = img_to_array(image)  # Convert to array and normalize
        image = np.expand_dims(image, axis=0)
        prediction = model.predict(image)
        predictedClass = np.argmax(prediction,axis=1)[0]

        with open("../classList.json","r") as file:
            classList = json.load(file)
            diagnosis = LabelParse(classList[int(predictedClass)])


            results = MakeRequest(diagnosis)

            response = {    
                "details": results,
               
            }   


    except Exception as error:
        response = {"error": str(error)}

    return jsonify(response)


if __name__ == "__main__":
    app.run(debug=True,host="0.0.0.0",port=8000)








    
