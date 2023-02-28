from notebook.auth import passwd
from dotenv import load_dotenv
from os import environ

def my_password(password : str) -> None:
    try:
        ReturnHashPassword = passwd(password, algorithm='sha256')
        
        with open("") as SaveJupyterFile:
            SaveJupyterSetup = f"""
                c.NotebookApp.allow_origin = '*'
                c.NotebookApp.open_browser = False
                c.NotebookApp.password = {ReturnHashPassword}
            """
            SaveJupyterFile.write(SaveJupyterSetup)
            SaveJupyterFile.close()
            return "Done"
    
    except:
        return "Error"


if __name__ == "__main__":
    load_dotenv()

    print(my_password(environ["MY_PASSWORD"]))