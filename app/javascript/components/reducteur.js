const initReducteur = () => {
    const titre_reducteurs = document.getElementsByClassName("titre_reducteur");
    if(titre_reducteurs != null) {
        for(let i = 0; i < titre_reducteurs.length; i++ ) {
            titre_reducteurs[i].addEventListener('click', (event) => {
                let content = titre_reducteurs[i].parentElement.children[1];
                let title = titre_reducteurs[i]
                if (content.style.display === '') {
                    content.style.display = 'block'
                    for(let titch = 0; titch < title.children.length; titch++ ) {
                        switch (title.children[titch].className) {
                            case ("i_reduit") :
                                title.children[titch].style.display = "none";
                                break;
                            case ("i_developpe") :
                                title.children[titch].style.display = "block";
                                break;
                        }
                    }
                } else {
                    content.style.display = ''
                    for(let titch = 0; titch < title.children.length; titch++ ) {
                        switch (title.children[titch].className) {
                            case ("i_reduit") :
                                title.children[titch].style.display = "block";
                                break;
                            case ("i_developpe") :
                                title.children[titch].style.display = "none";
                                break;
                        }
                    }
                }
            });
        };
    }


}

export { initReducteur };