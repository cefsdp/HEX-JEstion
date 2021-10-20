const initTableauHexSearchBar = () => {
    // Declare variables
    var input, filter, table, tr;
    input = document.getElementById("tableau_search_bar");
    table = document.getElementById("search_tableau");
    tr = document.getElementsByClassName("tabl_search_ligne");
    console.log(tr)

    // document.querySelectorAll('.tabl_search_ligne')[0].innerText.replaceAll('\t', ' ').includes('Charles') 
    // Loop through all table rows, and hide those who don't match the search query
    input.addEventListener('input', (event) => {
        filter = input.value.toUpperCase();
        console.log('eventlistener')
        for(let ligne of tr) {
            console.log('for')
            switch (ligne.innerText.toUpperCase().replaceAll('\t', ' ').replaceAll('\n', ' ').includes(filter)) {
                case true:
                    console.log('true')
                    ligne.style.display = '';
                    break;
                case false:
                    console.log('false')
                    ligne.style.display = 'none';
                    break;
                default:
                    console.log('Aucune entrée')
            }
            
        }
        
    });
}

export { initTableauHexSearchBar };