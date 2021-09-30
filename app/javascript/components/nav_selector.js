const initNavSelector = () => {
    
    let user_types = document.getElementsByClassName('profile');
    let nav_types = document.getElementsByClassName('nav_items');
    let usertoken = document.cookie.split('; ').find(row => row.startsWith('token=')).split('=')[1];
    let userparam = getUserparam(usertoken);
    initUserTypes(userparam);
    initNavTypes(userparam);

    
    
    for(let i = 0; i < user_types.length; i++ ) {
        user_types[i].addEventListener('click', (event) => {
            updateUserTypes(userparam, usertoken, i);
            updateNavTypes(i);
        });
    };
    
    function initUserTypes(userparam) {
        userparam.then((data) => {
            user_types[data.navbar_active].classList.add('active');
        })
    }

    function updateUserTypes(userparam, usertoken, i) {
        for(let user_type of user_types) {
            user_type.classList.remove('active');
        };
        user_types[i].classList.add('active');
        updateUserparam(userparam, usertoken, i);
    }

    function initNavTypes(userparam) {
        userparam.then((data) => { 
            nav_types[data.navbar_active].classList.add('active'); 
        })
    }

    function updateNavTypes(i) {
        for(let nav_type of nav_types) {
            nav_type.classList.remove('active');
        };
        nav_types[i].classList.add('active');
    }

    function getUserparam(token) {
        if (window.location.host == 'localhost:3000') {
            url = '/api/v1/userparams?authentication_token=' + token;
        } else {
            var url = '/api/v1/userparams?authentication_token=' + token;
            console.log(token)
        }
        var data = fetch(url).then((response) => response.json()).then((json) => {
            return json;
        }).catch((error) => {
            console.error(error);
        });
        return data
    }

    function updateUserparam(userparam, user_token, new_navbar_active) {
        return userparam.then((usparam) => {
            if (window.location.host == 'localhost:3000') {
                url = '/api/v1/userparams/' + usparam.id + '?authentication_token=' + user_token + '&navbar_active=' + new_navbar_active;
            } else {
                var url = new URL(window.location.host + '/api/v1/userparams/' + data.id + '?');
                var param = {'authentication_token': user_token, 'navbar_active': new_navbar_active};
                url.search = new URLSearchParams(param).toString();
            }
            var data = fetch(url)
                .then(response => response.json())
                .then((data) => {
                console.log(data.hits); // Look at local_names.default
                });
        });
    }
}
export { initNavSelector };
