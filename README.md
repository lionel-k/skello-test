**1/ Answers**

**Programmation Générale**

1. Ecrire une regexp qui détecterait les nombres hexadécimaux dans un text
‘0x0f4’, ‘0acdadecf822eeff32aca5830e438cb54aa722e3’, ‘8BADF00D’ devraient tous être détectés

> 0?[xX]?[0-9a-fA-F]+

2. Ci-dessous le pseudo-code d'une fonction récursive
-  f(0) = 1;
-  f(1) = 3;
-  f(n)= 3 * f(n-1) - f(n-2);
Implémentez la fonction f sans qu'elle soit récursive

```ruby
def f_non_recur(x)
  if x == 0
    1
  elsif x == 1
    3
  else
    previous = 1
    current = 3
    (2..x).each do
      new_current = 3 * current - previous
      previous = current
      current = new_current
    end
    current
  end
end

(0..10).each { |i| puts f_non_recur(i) }
```


**Ruby on Rails**

1. Quelles seraient les premières étapes à prendre pour refacto un projet où les controllers sont trop longs?

> * Comprendre s'il n'y a pas la possibilité de créer des classes de services
> * Voir la possibilité de créer d'autres classes qui ne sont pas des modèles ActiveRecord

2. Qu'est-ce que le N+1 et comment l'éviter en Rails?

> Le N+1 se présente lorsque l'on fait des requêtes ActiveRecord pour une ressource associée à une autre.
Dans l'exemple de l'application web de posts, c'est lorsque on fait une requête pour avoir la liste de tous les posts, et une requête pour chaque commentaire associé à un post.

> Cela arrive par exemple lorsqu'on itére sur la liste de tous les posts et que pour chaque itération on demande le nombre des commentaires associés, on fera n fois ces requêtes + la requête de demande de tous les posts d'où le N+1.

> Pour l'éviter: on peut inclure les commentaires dans un seul appel ActiveRecord et ainsi faire que 2 requêtes tout le temps au lieu de N+1

```ruby
# Ex:
@posts = Post.includes(:comments)
```

3. D'un point de vue pratique, quel intérêt à utiliser des constantes dans une app Rails? Quelles implémentations avez-vous vu/mis en place?

> L'intérêt d'utiliser des constantes dans une app Rails c'est de pouvoir les définir dans un seul endroit du projet et pouvoir les appeler n'importe où dans le projet.

> L'implémentation que j'ai mis en place pour le moment est la gestion des clés dans config/application.yml avec la gem figaro pour les cacher et les envoyer sur Heroku. ça me permet de gérer les clés de l'environnement de développement et de production sans se soucier qu'elle se retrouve un jour sur l'Internet.

4. Décrivez une fonction de Ruby trop peu utilisée à votre goût

> Je dois être franc. N'ayant que moins de 9 semaines de développement en Ruby, je ne saurais juger quelle fonction n'est pas assez utilisée comparée à d'autres. Avec l'expérience et on en voyant beaucoup dans l'avenir, je pourrais avoir la légimité de donner une réponse à cette question.

**Architecture**

1. Une entreprise veut créer un système de notification pour son site.
Chaque type de notification a besoin de 'variables' différentes:
(x a aimé le projet de y, le projet x vient d'être mis à jour, etc.)
La base de données est en PostgreSQL.
Proposez une structure de données et une implémentation en back-end qui permettrait d'être assez flexible
tout en réduisant la possibilité de bugs et de structures non conformes

> Les notifications peuvent être stockées en base dans une table 'notifications' avec un 'content' de type jsonb, un 'category' de type string.
Le champ 'content' permettra de gérer les 'variables' propres à chaque notification puisqu'un json avec différentes clés-valeurs pourra y être stocké.
Le champ 'category' sera utilisé dans le controller pour savoir quelle format la vue aura pour la dite la notification.

2. Décrivez les objets et la structure de donnée que vous utiliseriez pour implémenter un jeu de Touché-Coulé

> Pour la structure de donnée, une "table" en HTML peut faire l'affaire avec les "tr" qui représente les lignes du jeu et les "td" les cases.
> Comme c'est un jeu 'front' - on intéragit juste avec le navigateur par des clics - je n'utiliserai pas d'objets. Tout la logique du jeu irait dans un fichier JavaScript.



**2/ Sinatra Exercise**

To run the app locally:

```bash
git clone git@github.com:lionel-k/skello-test.git
bundle install
```

In ```config/database.yml```, yield the ```username``` of your local machine for postgresql and a ```password``` if needed.

Then setup the database with:
```
rake db:create
rake db:migrate
rake db:seed
```

Then launch the app:

```
ruby app.rb
```

The app is also live on Heroku:

=> [Heroku](https://posts-app-skello-test.herokuapp.com/)
