import datetime
from django.db import models
from django.conf import settings
from django.utils import timezone
from django.core.validators import MaxValueValidator
# Create your models here.

class MonitoredTimeModel(models.Model):
	creation_time = models.DateTimeField(auto_now_add=True)
	update_time = models.DateTimeField(auto_now=True)

	class Meta:
		abstract = True

class District(MonitoredTimeModel):
	label = models.CharField(max_length=50, blank=False,help_text="Le nom du district")
	
	def __str__(self):
		return self.label


class Patient(MonitoredTimeModel):
    code_patient = models.CharField(max_length=10, blank=False)
    genre = models.CharField(max_length=50, blank=False,help_text="Le genre")
    datenaissance = models.DateField("Date de naissance")

    def __str__(self):
        return "{} {}".format(self.datenaissance, self.genre)

class Ville(MonitoredTimeModel):
    label = models.CharField(max_length=50, blank=False,help_text="Le nom de la ville")

    def __str__(self):
        return self.label

class Enregistrement(MonitoredTimeModel):
	code_patient = models.ForeignKey("Patient", on_delete = models.PROTECT, related_name="enregistrement")
	copies_ARN = models.IntegerField(blank=False)
	log_copies_ARN = models.IntegerField(blank=False)
    #date_prelevement = models.DateField("Date du prélèvement")
    #date_traitement = models.DateField(blank=False, validators = [MaxValueValidator(datetime.datetime.now().date())])
    #nbre_echantillon_recu = models.IntegerField(blank=False)
    #date_reception_echantillon = models.DateField(blank=False, validators = [MaxValueValidator(datetime.datetime.now().date())])
    #ddate_retrait_resultat_echantillon = models.DateField(blank=False, validators = [MaxValueValidator(datetime.datetime.now().date())])
    #nbre_resultat_recu = models.IntegerField(blank=False)

	def __str__(self):
		return self.code_patient
        