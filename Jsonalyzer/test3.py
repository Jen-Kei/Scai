import tkinter as tk
from tkinter import ttk
import customtkinter as ctk
import pandas as pd
import json

FILENAME = "C:\\Code\\Kei&Jei\\Treasures\\TreasuresCC.json"
window = ctk.CTk()
window.title("Jsonalyzer")
window.geometry("1000x400")
cols = [0.1, 0.3, 0.5, 0.7, 0.9]
rows = [0.1, 0.16, 0.22, 0.28, 0.34, 0.4, 0.46, 0.52, 0.58, 0.64, 0.7, 0.76, 0.82, 0.88, 0.94]
found_loop = False
current_row = 0
current_col = 4

# Read the JSON data from the file
with open(FILENAME, 'r') as file:
    json_data = file.read()

# Parse the JSON data into a Python object
data = json.loads(json_data)

common_button = ctk.CTkButton(window, text="Common", command=lambda: (clear_buttons(), display_items(data['Items']['Rarity']['Common'])))
common_button.place(relx=cols[0], rely=rows[0], anchor="center")

uncommon_button = ctk.CTkButton(window, text="Uncommon", command=lambda: (clear_buttons(), display_items(data['Items']['Rarity']['Uncommon'])))
uncommon_button.place(relx=cols[0], rely=rows[2], anchor="center")

rare_button = ctk.CTkButton(window, text="Rare", command=lambda: (clear_buttons(), display_items(data['Items']['Rarity']['Rare'])))
rare_button.place(relx=cols[0], rely=rows[4], anchor="center")

epic_button = ctk.CTkButton(window, text="Epic", command=lambda: (clear_buttons(), display_items(data['Items']['Rarity']['Epic'])))
epic_button.place(relx=cols[0], rely=rows[6], anchor="center")

def display_items(dataR):
    global current_row, current_col
    current_row = 0
    for i in dataR:
        print(i['Name'])
        item_button = ctk.CTkButton(window, text=i['Name'], command=lambda i=i: display_item_stats(dataR, i['Name']))
        item_button.place(relx=cols[1], rely=rows[current_row], anchor="center")

        item_buttons.append(item_button)
        current_row += 2

    current_row = 0
    current_col = 4

def display_item_stats(dataR, name):
    global current_row, current_col, found_loop
    # destroy the buttons
    clear_labels_and_entry_boxes()
    for object in dataR:
        if object['Name'] == name:
            for key in object:
                txtLabel_Key = ctk.CTkLabel(window, text=key, font=("Arial", 10))
                txtLabel_Key.place(relx=cols[current_col-1], rely=rows[current_row], anchor="center")

                txtBox_Value = ctk.CTkEntry(window, font=("Arial", 10), height=10)
                txtBox_Value.insert(0, object[key])
                txtBox_Value.place(relx=cols[current_col], rely=rows[current_row], anchor="center")

                # Keep track of labels and entry boxes
                labels_and_entry_boxes.append((txtLabel_Key, txtBox_Value))

                current_row += 1
    current_row = 0
    current_col = 4

def clear_labels_and_entry_boxes():
    # Destroy existing labels and entry boxes
    for label, entry in labels_and_entry_boxes:
        label.destroy()
        entry.destroy()

    # Clear the list
    labels_and_entry_boxes.clear()

def clear_buttons():
    # Destroy existing labels and entry boxes
    for widget in item_buttons:
        widget.destroy()

    # Clear the list
    item_buttons.clear()

def save_changes():
    try:
        # Update the JSON data with the new values from entry boxes
        for label, entry in labels_and_entry_boxes:
            for object in data['Items']['Rarity'].values():
                for item in object:
                    if item['Name'] == label.cget("text"):
                        item[label.cget("text")] = entry.get()

        # Write the updated JSON data back to the file
        with open(FILENAME, 'w') as file:
            json.dump(data, file, indent=4)
        print("Changes saved successfully!")
    except Exception as e:
        print("An error occurred while saving changes:", e)




# Add a save button
save_button = ctk.CTkButton(window, text="Save Changes", command=save_changes)
save_button.place(relx=0.5, rely=0.95, anchor="center")

# Define a list to keep track of labels and entry boxes
labels_and_entry_boxes = []
item_buttons = []

window.mainloop()
