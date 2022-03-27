import Chart from 'chart.js/auto';

const initHalfDoughnutChart = () => {
    if (document.getElementById('halfdoughnutchart') != null) {
        var ctx = document.getElementById("halfdoughnutchart").getContext('2d');
        var datasets = JSON.parse(ctx.canvas.dataset.data);
        // Parse DataSets
        var parsedDataSet = {}
        for (let i = 0; i < datasets.length; i++) {
            const dataset = datasets[i];
            parsedDataSet[dataset[0]] = dataset[1]
        };
        console.log(parsedDataSet)
        
        var dashboardChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: JSON.parse(ctx.canvas.dataset.labels),
                datasets: [ parsedDataSet ],
            },
            options: {
                rotation: 270,
                circumference: 180,
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: false,
                    },
                },
                cutoutPercentage: 95,
            },
        });
    }
}

export { initHalfDoughnutChart };