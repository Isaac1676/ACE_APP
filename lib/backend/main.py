from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from models import create_user, get_user_by_id, delete_user, update_user

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///tuto.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Instance SQLAlchemy
db = SQLAlchemy(app)

class Lover(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    boy = db.Column(db.String(80), unique=True, nullable=False)
    girl = db.Column(db.String(120), unique=True, nullable=False)

    def __repr__(self):
        return '<User %r>' % self.username

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

    def __repr__(self):
        return '<User %r>' % self.username


with app.app_context():
    # Création des tables dans la base de données
    db.create_all()

    # Exemples d'utilisation des fonctions CRUD du fichier crud.py
    # Création d'un utilisateur
    user1 = create_user('Sev', 'Sev@example.com')

    # Récupération de l'utilisateur par ID et affichage
    user = get_user_by_id(user1.id)
    print(user)

    # Mise à jour de l'utilisateur
    updated_user = update_user(user1.id, 'John Low', 'john.low@example.com')
    print(updated_user)

    # Suppression de l'utilisateur
    delete_result = delete_user(user1.id)
    print(delete_result)
