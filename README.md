# AppBilanSanguin
pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py makemigrations SuiviBilanS
python manage.py migrate
python manage.py runserver
