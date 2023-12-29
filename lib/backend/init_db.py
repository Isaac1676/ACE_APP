from main import app, db
from models import User  # Assure-toi du bon chemin d'importation

# Contexte d'application pour SQLAlchemy
with app.app_context():
    # Création des tables dans la base de données
    db.create_all()
