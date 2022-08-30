user www-data; 
worker_processes 4; 
pid /var/run/nginx.pid;
events {
     worker_connections 5000;
     use epoll;
     # multi_accept on; 
} # took it in next line
worker_rlimit_nofile    100000;

http {
     sendfile on;
     tcp_nopush on;
     tcp_nodelay on;
     keepalive_timeout 600;
     send_timeout 600;
     proxy_connect_timeout       600;
     proxy_send_timeout          600;
     proxy_read_timeout          600;
     reset_timedout_connection on;
     types_hash_max_size 2048;
     client_header_buffer_size 5k;
     open_file_cache max=1000000 inactive=30s;
     open_file_cache_valid    60s;
     open_file_cache_min_uses 2;
     open_file_cache_errors   on;
     include /etc/nginx/mime.types;
     default_type application/octet-stream;
     access_log off; 
     error_log /var/log/nginx/error.log;
     gzip on;
     gzip_disable "msie6";
     include /etc/nginx/conf.d/*.conf;
     include /etc/nginx/sites-enabled/*; 
}
