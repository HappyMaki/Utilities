import yaml 
import os
import sys

CWD = os.getcwd()
input = sys.argv[1]
game_ready = False
about_item_index = -1

def create_menu_item():
    new_menu_item = {"title": input, "url": f"/{input.lower()}/"}
    about_item = config["menu"].pop(about_item_index)
    config["menu"].append(new_menu_item)
    config["menu"].append(about_item)

    with open(os.path.join(CWD, "_config.yml"), "w") as file:
        documents = yaml.dump(config, file)


def create_markdown_from_template():
    with open(os.path.join(CWD, "_templates", "new_game.md"), "r") as file:
        markdown_template = file.read()
        markdown_file = markdown_template.replace("$TITLE", input)

    with open(os.path.join(CWD, "_featured_categories", f"{input}.md"), "w") as file:
        file.write(markdown_file)


def create_post_directory():
    os.umask(0)
    os.mkdir(os.path.join(CWD, "_posts", f"{input}"), 777)


with open(os.path.join(CWD, "_config.yml")) as file:
    config = yaml.load(file, Loader=yaml.FullLoader)

for i in range(len(config["menu"])):
    if config["menu"][i]["title"] == input:
        game_ready = True
    if config["menu"][i]["title"] == "About":
        about_item_index = i
    

if not game_ready:
    create_menu_item()
    create_markdown_from_template()
    create_post_directory()

print("Game ready!")