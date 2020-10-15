echo "Running nginx..."
nginx -g "daemon off;" &
export PID="$!"
echo "...nginx is now running: ${PID}"
