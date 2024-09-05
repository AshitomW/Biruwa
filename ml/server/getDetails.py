from dotenv import load_dotenv
import os
import google.generativeai as genAI
from flask import jsonify
import json


load_dotenv()
API_KEY = os.getenv("API_KEY")
GEN_MODEL = os.getenv("GEN_MODEL")







def MakeRequest(diagnosis):
 
    print(diagnosis)
    name,prediction = diagnosis['name'],diagnosis['diagnosis']
    


    
    genAI.configure(api_key=API_KEY)
    model = genAI.GenerativeModel(GEN_MODEL)


  



    response = model.generate_content(
    f"Explain the diagnosis for given  plant name and diagnosis. Respond in JSON format with the following structure: "
    "{"
    f"  'name': '{name}',"
    f"  'diagnosis': '{prediction}',"
    "  'explanation': 'example : Black rot is a fungal disease caused by Guignardia bidwellii that affects grapevines, leading to dark spots and fruit decay.',"
    "  'suggestions': example:['Remove infected leaves and fruits.', 'Apply fungicides early in the season.', 'Ensure good air circulation by pruning.']"
    "}"
    )
    parsedText = response.text.strip("```json\n").strip("\n```")
    responseDict =json.loads(parsedText);
    return responseDict



