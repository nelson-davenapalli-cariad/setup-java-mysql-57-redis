echo ">>> Starting services .... "
./start_serviecs.sh
echo ">>> done "

RETURN_CODE=0
{ # try
    echo "Running command $2"
    $2
    echo ">>> Stopping services .... "
    ./stop_services.sh
    echo ">>> done "

} || { # catch
    RETURN_CODE=1
}
exit $RETURN_CODE