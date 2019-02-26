## récupération et modification d'un noeud XML à ajouter :
  # je télécharge depuis le FTP le fichier contenant le noeud XML
  # je récupère le noeud XML
  # je modifie le noeud XML le cas échéant

## ajout d'un noeau XML dans le XML cible :
  # je récupère/je créé le fichier XML cible
    # si un fichier product_id.xml existe déjà
      # je le récupère
    # sinon
      # je le créé
      # je le récupère
  # j'insère/je modifie le noeud XML
  # j'enregistre le fichier cible

## création du XML cible :
  # je récupère le XML base sur le FTP
  # je l'enregistre en local avec l'id du produit en nom
