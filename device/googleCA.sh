openssl s_client -servername www.googleapis.com -showcerts \
>  -connect www.googleapis.com:443 < /dev/null \
>  |  awk '/^-----BEGIN CERTIFICATE-----/,/^-----END CERTIFICATE-----/{if(++m==1)n++;if(n==2)print;if(/^-----END CERTIFICATE-----/)m=0}' \
>  > googleCA.cer