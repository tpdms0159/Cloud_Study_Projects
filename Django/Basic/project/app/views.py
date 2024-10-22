from django.shortcuts import render

from django.http import HttpResponse
from app.models import Item


def index(request):
    # return HttpResponse("Hello Django")
    
    # 프론트에 데이터를 넘겨주는 방법
    # msg = 'My Message'
    # return render(request, 'index.html', {'message': msg})

    # 데이터 베이스 연결
    print(Item)
    data = Item.objects.all()
    return render(request, 'index.html', {'data': data})
