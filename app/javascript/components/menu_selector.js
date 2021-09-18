const initMenuSelector = () => {
    let menu_tabs = document.getElementsByClassName('tab')
    let menu_contents = document.getElementsByClassName('content')

    for(let i = 0; i < menu_tabs.length; i++ ) {
        menu_tabs[i].addEventListener('click', (event) => {
            updateMenuTabs(i);
            updateMenuContents(i);
        });
    };

    function updateMenuTabs(i) {
        for(let menu_tab of menu_tabs) {
            menu_tab.classList.remove('active');
        };
        menu_tabs[i].classList.add('active');
    }

    function updateMenuContents(i) {
        for(let menu_content of menu_contents) {
            menu_content.classList.remove('active');
        };
        menu_contents[i].classList.add('active');
    }
}

export { initMenuSelector };