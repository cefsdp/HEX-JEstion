const initNavSelector = () => {
    let user_types = document.getElementsByClassName('profile');
    let nav_types = document.getElementsByClassName('nav_items');
    
    for(let i = 0; i < user_types.length; i++ ) {
        user_types[i].addEventListener('click', (event) => {
            updateUserTypes(i);
            updateNavTypes(i);
        });
    };

    function updateUserTypes(i) {
        for(let user_type of user_types) {
            user_type.classList.remove('active');
        };
        user_types[i].classList.add('active');
    }

    function updateNavTypes(i) {
        for(let nav_type of nav_types) {
            nav_type.classList.remove('active');
        };
        nav_types[i].classList.add('active');
    }
}
export { initNavSelector };