import Chart from 'chart.js/auto';

const initBarChart = () => {
    if (document.getElementById('barChart') != null) {
        var ctx = document.getElementById('barChart').getContext('2d');
        var datasets = JSON.parse(ctx.canvas.dataset.data);

        // Parse DataSets
        var parsedDataSet = []
        for (let i = 0; i < datasets.length; i++) {
            const dataset = datasets[i];
            var result = dataset.reduce((map, obj) => {
                map[obj[0]] = obj[1];
                return map;
            }, {});
            parsedDataSet.push(result)
        };

        
        // Chart
        var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: JSON.parse(ctx.canvas.dataset.labels),
            datasets: parsedDataSet
            //JSON.parse(ctx.canvas.dataset.data),
        },
        options: {
            scales: {
                y: {
                display: true,
                ticks: {
                    color: "#000000",
                    font: {
                        family: "'Poppins', sans-serif",
                        size: 14,
                        weight: 800,
                    },
                }
                },
                x: {
                    display: true,
                    ticks: {
                        color: "#000000",
                        font: {
                            family: "'Poppins', sans-serif",
                            size: 14,
                            weight: 800,
                        },
                    }
                },
            },
            responsive: true,
            animations: {
                radius: {
                duration: 1500,
                easing: 'linear',
                loop: (context) => context.active
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'bottom',
                    labels: {
                        fontColor: "black",
                        fontSize: 30,
                    }
                },
                title: {
                    display: false,
                    text: "Chiffre d'Affaire de la structure"
                }
            },
        },
        });
    }
}

export { initBarChart };