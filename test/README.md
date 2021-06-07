Exercice: ICO & Calculator
Créer un ERC20 en utilisant les librairies d'OpenZepplin.

Assigner la total supply à un utilisateur qui possédera tous les tokens, c'est l'owner.

Créer un smart contract ICO qui permettra à des utilisateurs d'acheter les tokens de l'owner.

1 Token (1 x 10^18) pourra être obtenu pour 1 gwei.
Les utilisateurs auront 2 possibilités pour acheter ces tokens:
Envoyer directement les ethers qui seront réceptionnés par une fonction receive (déjà vu en cours)
Utiliser une fonction buyTokens() qui sera payable afin de supporter l'envoi d'ethers.
Le smart contract devra posséder un owner, vous pouvez utiliser Ownable.sol que nous avons déjà vu en cours, ou encore mieux utiliser Ownable.sol. Lire https://docs.openzeppelin.com/contracts/4.x/api/access#Ownable pour plus d'information.
L'ICO devra durer 2 semaines à partir du déploiement du smart contract. Après 2 semaines la vente de token sera clôturée.
L'owner pourra withdraw toute la balance du smart contract ICO lorsque l'ICO sera terminée, c'est à dire 2 semaines après le déploiement.
Ajouter des getters utilitaires pour obtenir le montant des wei gagnés, le nombre de tokens vendus, le prix en wei d'un token etc...
Ajouter des events.
Créer un smart contract Calculator qui nécessitera 1 de vos tokens pour effectuer l'une des 5 opérations arithmétiques d'addition, soustraction, multiplication, division et modulo. Ces fonctions devront retourner le résultat de l'opération et aussi émettre un event afin que l'on puisse récupérer ce résultat depuis notre Frontend. Par exemple la fonction add devra être déclarée ainsi:

function add(int256 nb1, int256 nb2) public returns(int256) {
    // insérer votre code ici
}
Vous pouvez y ajouter des modifiers si c'est nécéssaire.
Ce smart contract possédera un owner qui pourra withdraw les tokens accumulés par le smart contract.

Vous devrez fournir les tests unitaires qui justifieront du bon fonctionnement de vos smart contracts. Attention à bien penser à approve le smart contract de l'ICO en tant qu'owner des tokens afin d'autoriser le smart contract de l'ICO à transférer les tokens aux acheteurs dans vos tests et aussi à approve le smart contract Calculator en tant qu'utilisateur pour que le smart contract Calculator puisse utiliser la fonction transferFrom.
