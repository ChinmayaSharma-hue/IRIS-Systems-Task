# IRIS-Systems-Task

### Task 7
Add requests rate limit to Nginx to limit the number of HTTP requests to the application in a given period.

Changes need to be made to the `nginx.`conf` file to include the requests limit context within HTTP and to define the total number of requests per second as 5, and to accommodate bursts by having a queue of 20 slots so that requests are served as soon as they are made.

- nginx.conf,
    ```
    user www-data;
    worker_processes auto;
    pid /run/nginx.pid;
    include /etc/nginx/modules-enabled/*.conf;

    events {}
    http {
        limit_req_zone $binary_remote_addr zone=mylimit:10m rate=5r/s;

        upstream backend {
            server app1:3000 weight=1;
            server app2:3000 weight=1;
            server app3:3000 weight=1;
        }
        
        server {
            listen 8080;
            server_name localhost 127.0.0.1;
            location / {
                limit_req zone=mylimit burst=20 nodelay;

                proxy_pass  http://backend;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;

            }
        }
    }

    ```
