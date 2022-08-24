from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import os

# Google Cloud SQL
USERNAME = "root"
PASSWORD = "mypassword"
PUBLIC_IP_ADDRESS = "127.0.0.1"
DBNAME = "todo"
PROJECT_ID = "codimite"
INSTANCE_NAME = "main-instance"

# USERNAME= os.environ.get('USERNAME')
# PASSWORD= os.environ.get('PASSWORD')
# DBNAME= os.environ.get('DBNAME')
# PUBLIC_IP_ADDRESS= os.environ.get('PUBLIC_IP_ADDRESS')
# PROJECT_ID= os.environ.get('PROJECT_ID')
# INSTANCE_NAME= os.environ.get('INSTANCE_NAME')

app = Flask(__name__)


app.config["SQLALCHEMY_DATABASE_URI"]= f"mysql+mysqldb://{USERNAME}:{PASSWORD}@{PUBLIC_IP_ADDRESS}/{DBNAME}?unix_socket=/cloudsql/{PROJECT_ID}:{INSTANCE_NAME}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"]= True

# app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite'
# app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class Todo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100))


@app.route('/')
def home():
    todo_list = Todo.query.all()
    return render_template("index.html")


@app.route("/add", methods=["POST"])
def add():
    title = request.form.get("title")
    new_todo = Todo(title=title)
    db.session.add(new_todo)
    db.session.commit()
    return redirect(url_for("home"))


@app.route("/list")
def list():
    todo_list = Todo.query.all()
    return render_template("index.html", todo_list=todo_list)


@app.route("/delete/<int:todo_id>")
def delete(todo_id):
    todo = Todo.query.filter_by(id=todo_id).first()
    db.session.delete(todo)
    db.session.commit()
    return redirect(url_for("home"))


if __name__ == "__main__":
    db.create_all()
    app.run(host="0.0.0.0")
