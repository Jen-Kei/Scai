import tkinter as tk
from tkinter import ttk
import customtkinter as ctk
import pandas as pd
import json

FILENAME = "C:\\Code\\Kei&Jei\\Treasures\\Treasures.json"

cols = [0.1, 0.3, 0.5, 0.7, 0.9]
rows = [0.1, 0.3, 0.5, 0.7, 0.9]

current_row = 0
current_col = 0

def load_json():
	with open(FILENAME, "r") as file:
		data = json.load(file)
		return data

jData = load_json()

window = ctk.CTk()
window.title("Jsonalyzer")
window.geometry("800x500")

class Data:
	def __init__(self, data):
		self.data = data


def display_data(data):
    global current_row, current_col
    current_row = 0
    for i in data:
        button = ctk.CTkButton(window, text=i, command=lambda i=i: (display_data(data[i]), print(i, 'clicked')))
        button.place(relx=cols[current_col], rely=rows[current_row], anchor="center")
        current_row += 1
    current_col += 1


display_data(jData)


window.mainloop()

