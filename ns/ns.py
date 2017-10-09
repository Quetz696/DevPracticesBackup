#!/usr/bin/python3
import os
import requests
import xml.etree.ElementTree as ET
import smtplib
import email
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from genshi.template import MarkupTemplate
import genshi
import genshi.template
from email.message import EmailMessage
import time

import re

def cleanhtml(raw_html):
  cleanr = re.compile('<.*?>')
  cleantext = re.sub(cleanr, '', raw_html)
  return cleantext

username = 'rftb.dev@gmail.com'
ww = 'az7GQIOTBI2qd163vrUTJGwuNBpGk0rilJr8XSWh61ikWKDf3AngUQ'
frompassw = 'eentrein'
baseUrl = 'http://webservices.ns.nl/ns-api-storingen?station=Apeldoorn&actual=true&unplanned=true'
resp = requests.get(baseUrl, auth=(username, ww))
respcontent = resp.content
tree = ET.fromstring(respcontent)
UNSCHEDULED = tree.find('Ongepland')
SCHEDULED = tree.find('Gepland')

content = []
UNSCHEDULEDlist =UNSCHEDULED.getchildren()
SCHEDULEDlist =SCHEDULED.getchildren()

if len(UNSCHEDULED.getchildren()) != 0:
       for malfunction in UNSCHEDULED:
           info = {
               "scheduled": False,
               "unscheduled": True,
               "state" : "Ongeplande",
               "id" : malfunction.find('id').text,
               "traject" : malfunction.find('Traject').text,
                "periode" : "",
               "reden" : malfunction.find('Reden').text,
               "bericht" : cleanhtml(malfunction.find('Bericht').text),
               "datum" : malfunction.find('Datum').text,
           }
           content.append(info)

if len(SCHEDULED.getchildren()) != 0:
       for malfunction in SCHEDULED:
           info = {
               "scheduled": True,
               "unscheduled": False,
               "state": "Geplande",
               "id" : malfunction.find('id').text,
               "traject" : malfunction.find('Traject').text,
               "periode" : malfunction.find('Periode').text,
               "reden" : "",
              "bericht" : cleanhtml(malfunction.find('Bericht').text),
               "datum" : "",
           }
        #    print(info)
           content.append(info)



template_dir = os.path.join(os.path.dirname(__file__), 'htmltemplates')
loader = genshi.template.TemplateLoader(template_dir, auto_reload=True)

def generateHtml(content):
    template_name = "ns.html"
    template = loader.load(template_name)
    # stream = template.generate(unscheduled = UNSCHEDULED, scheduled = SCHEDULED)
    stream = template.generate(message = content)
    rendered =  stream.render('html', doctype='html5')
    return rendered


html = generateHtml(content)


def makemailmessage(html):
    fromaddr = 'treinstoringnotificatie@gmail.com'
    toaddr = "roberttenbosch@gmail.com"

    msg = MIMEMultipart('alternative')
    msg['From'] = fromaddr
    msg['To'] = toaddr
    if len(UNSCHEDULEDlist) == 0:
        msg['Subject'] = "Geen ongeplande storingen " + time.strftime("%c")
    else:
        msg['Subject'] = "***let op*** Ongeplande storingen " + time.strftime("%c")
    htmlpart = MIMEText(html, 'html')
    msg.attach(htmlpart)
    return msg

mailmessage = makemailmessage(html)

# print(body)
server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login(mailmessage['From'], frompassw)
print( 'login succes')
# text = msg.as_string()
# server.sendmail(fromaddr, toaddr, msg)
server.send_message(mailmessage)
server.quit()
print("mail send")
