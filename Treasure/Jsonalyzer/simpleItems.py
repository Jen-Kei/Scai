
import tkinter as tk
from tkinter import ttk
import json

FILENAME = "C:\\Code\\Kei&Jei\\Treasures\\TreasuresCC.json"

# ChatGPT created this entire thing

class ItemApp:
    def __init__(self, master):
        self.master = master
        self.master.title("Item Editor")
        
        self.item_type_var = tk.StringVar()
        self.item_type_var.set("Common")
        
        self.name_var = tk.StringVar()
        self.description_var = tk.StringVar()
        self.sprite_var = tk.StringVar()
        self.weight_var = tk.DoubleVar()
        self.value_var = tk.DoubleVar()
        self.stamina_capacity_var = tk.DoubleVar()
        self.stamina_gain_var = tk.DoubleVar()
        self.stamina_per_second_var = tk.DoubleVar()
        self.health_capacity_var = tk.DoubleVar()
        self.health_gain_var = tk.DoubleVar()
        self.weight_capacity_var = tk.DoubleVar()
        self.fire_rate_var = tk.DoubleVar()
        
        self.create_widgets()
    
    def create_widgets(self):
        frame = ttk.Frame(self.master)
        frame.grid(row=0, column=0, padx=10, pady=10)
        
        ttk.Label(frame, text="Item Type:").grid(row=0, column=0, sticky="w")
        item_type_combobox = ttk.Combobox(frame, textvariable=self.item_type_var, 
                                          values=["Common", "Uncommon", "Rare", "Epic"])
        item_type_combobox.grid(row=0, column=1, sticky="w")
        
        ttk.Label(frame, text="Name:").grid(row=1, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.name_var).grid(row=1, column=1, sticky="w")
        
        ttk.Label(frame, text="Description:").grid(row=2, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.description_var).grid(row=2, column=1, sticky="w")
        
        ttk.Label(frame, text="Sprite:").grid(row=3, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.sprite_var).grid(row=3, column=1, sticky="w")
        
        ttk.Label(frame, text="Weight:").grid(row=4, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.weight_var).grid(row=4, column=1, sticky="w")
        
        ttk.Label(frame, text="Value:").grid(row=5, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.value_var).grid(row=5, column=1, sticky="w")
        
        ttk.Label(frame, text="Stamina Capacity:").grid(row=6, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.stamina_capacity_var).grid(row=6, column=1, sticky="w")
        
        ttk.Label(frame, text="Stamina Gain:").grid(row=7, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.stamina_gain_var).grid(row=7, column=1, sticky="w")
        
        ttk.Label(frame, text="Stamina Per Second:").grid(row=8, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.stamina_per_second_var).grid(row=8, column=1, sticky="w")
        
        ttk.Label(frame, text="Health Capacity:").grid(row=9, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.health_capacity_var).grid(row=9, column=1, sticky="w")
        
        ttk.Label(frame, text="Health Gain:").grid(row=10, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.health_gain_var).grid(row=10, column=1, sticky="w")
        
        ttk.Label(frame, text="Weight Capacity:").grid(row=11, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.weight_capacity_var).grid(row=11, column=1, sticky="w")
        
        ttk.Label(frame, text="Fire Rate:").grid(row=12, column=0, sticky="w")
        ttk.Entry(frame, textvariable=self.fire_rate_var).grid(row=12, column=1, sticky="w")
        
        ttk.Button(frame, text="Add Item", command=self.add_item).grid(row=13, columnspan=2)
    
    def add_item(self):
        item = {
            "Name": self.name_var.get(),
            "Description": self.description_var.get(),
            "Sprite": self.sprite_var.get(),
            "Weight": self.weight_var.get(),
            "Value": self.value_var.get(),
            "StaminaCapacity": self.stamina_capacity_var.get(),
            "StaminaGain": self.stamina_gain_var.get(),
            "StaminaPerSecond": self.stamina_per_second_var.get(),
            "HealthCapacity": self.health_capacity_var.get(),
            "HealthGain": self.health_gain_var.get(),
            "WeightCapacity": self.weight_capacity_var.get(),
            "FireRate": self.fire_rate_var.get()
        }
        
        item_type = self.item_type_var.get()
        with open(FILENAME, "r+") as file:
            data = json.load(file)
            data["Items"]["Rarity"][item_type].append(item)
            file.seek(0)
            json.dump(data, file, indent=4)
        
        self.clear_fields()
    
    def clear_fields(self):
        self.name_var.set("")
        self.description_var.set("")
        self.sprite_var.set("")
        self.weight_var.set(0)
        self.value_var.set(0)
        self.stamina_capacity_var.set(0)
        self.stamina_gain_var.set(0)
        self.stamina_per_second_var.set(0)
        self.health_capacity_var.set(0)
        self.health_gain_var.set(0)
        self.weight_capacity_var.set(0)
        self.fire_rate_var.set(0)

def main():
    root = tk.Tk()
    app = ItemApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()
