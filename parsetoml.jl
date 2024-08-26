# Importer la bibliothèque TOML
using TOML

# Fonction pour charger et lire un fichier TOML
function lire_toml(filepath::String)
    try
        # Lire le contenu du fichier TOML
        contenu = TOML.parsefile(filepath)
        return contenu
    catch e
        println("Erreur lors de la lecture du fichier TOML: ", e)
        return nothing
    end
end

# Fonction pour récupérer la valeur d'une clé spécifique
function requeter_toml(contenu::Dict, cle::String)
    try
        # Extraire la valeur de la clé spécifiée
        # Utiliser `Base.getproperty` pour accéder aux clés TOML en chemin (par exemple, "serveur.port")
        cles = split(cle, ".")
        valeur = contenu
        for c in cles
            valeur = valeur[c]
        end
        return valeur
    catch e
        println("Erreur lors de la requête de la clé: ", e)
        return "Erreur"
    end
end

# Chemin du fichier TOML
filepath = "config.toml"  # Remplacez par le chemin réel de votre fichier TOML

# Lire le contenu du fichier TOML
contenu_toml = lire_toml(filepath)

# Si le fichier a été lu correctement
if contenu_toml !== nothing
    # Exemples de clés à rechercher dans le fichier TOML
    cles = ARGS

    # Requêter les valeurs pour chaque clé
    for cle in cles
        valeur = requeter_toml(contenu_toml, cle)
        println("La valeur pour la clé '$cle' est: $valeur")
    end
else
    println("Impossible de lire le fichier TOML.")
end

