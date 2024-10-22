from django.db import models

class Item(models.Model):
    itemid = models.CharField(max_length=50,primary_key=True) 
    itemname=models.CharField(max_length=50) 
    price=models.IntegerField() 
    description=models.CharField(max_length=50)
    pictureurl = models.CharField(max_length=50)
