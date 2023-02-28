def NginxSetup(
    ProxyURL : str,
    WebProxyPort : int) -> None:

    NginxFileSet = f"""
        upstream jupyter {{
            server Test-Jupyter:8888 fail_timeout=0;
        }}

        map $http_upgrade $connection_upgrade {{
            default upgrade;
            '' close;
        }}

        server {{
            listen {WebProxyPort} default_server ipv6only=on;

            server_name {ProxyURL};

            client_max_body_size 100M;

            location ~* / {{
                proxy_pass http://jupyter;
                # WebSocket support
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection $connection_upgrade;

                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            }}
        }}
    """

    with open("/etc/nginx/sites-available/default", "w", encoding="utf8") as NginxSet:
        NginxSet.write(NginxFileSet)
        NginxSet.close()
    
    return None

if __name__ == "__main__":
    try:
        from dotenv import load_dotenv
        from os import environ

        load_dotenv()
        envDate = environ
        
        NginxSetup(
            envDate.get("ProxyURL"),
            envDate.get("WebProxyPort")
        )
        
        print("Done!")
    except:
        print("Error!")