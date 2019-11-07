echo ""; echo "${encrypted_secret}" | base64 --decode | keybase pgp decrypt; echo ""
