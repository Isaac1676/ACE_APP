from main import db, User  # Assurez-vous d'importer votre instance de base de données et le modèle User

def create_user(username, email):
    nouvel_utilisateur = User(username=username, email=email)
    db.session.add(nouvel_utilisateur)
    db.session.commit()
    return nouvel_utilisateur

def get_user_by_id(user_id):
    return User.query.get(user_id)

def update_user(user_id, new_username, new_email):
    user = User.query.get(user_id)
    if user:
        user.username = new_username
        user.email = new_email
        db.session.commit()
        return user
    return None

def delete_user(user_id):
    user = User.query.get(user_id)
    if user:
        db.session.delete(user)
        db.session.commit()
        return True
    return False


