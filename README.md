# codimite-assignment
> Desc: Repo for the codimite devops assingnment


## Setup Todo App

The program is written with the Python Flask framework, HTML and CSS. 

Install the requirements using; 

```
pip install -r /path/to/requirements.txt
```

Run the  application using;

```
python3 app.py
```


## API Endpoints

- /add : adds a new task to the database
```
<IP_ADDRESS>:5000/add
```
- /list : list all the tasks in the database
```
<IP_ADDRESS>:5000/list
```
- /delete : deletes a task in the datase
```
<IP_ADDRESS>:5000/delete/<ID>
```