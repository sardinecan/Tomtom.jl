using TOML

# this function reads the toml file
function readTomlFile(filepath::String)
    try
        content = TOML.parsefile(filepath)
        return content
    catch e
        println("Erreur lors de la lecture du fichier TOML : ", e)
        return nothing
    end
end

# 
function queryTomlFile(parsedTomlFile::Dict, query::String)
    try
        keys = split(query, ".") # tokenize query
        value = parsedTomlFile
        for key in keys # update $value variable by descending in the keys
          value = value[key]
        end
        return value
    catch e
        println("Erreur lors de la requête de la clé: ", e)
        return "Erreur"
    end
end


filepath = ARGS[1] # filepath given by the first arg
tomlfile = readTomlFile(filepath)

if tomlfile !== nothing
  queries = ARGS[2:end] 
  for query in queries
    value = queryTomlFile(tomlfile, query)
    println("$query : $value")
  end
else
    println("Impossible de lire le fichier TOML.")
end
