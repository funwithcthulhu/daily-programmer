test1 = [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]

function mountain(arr) {
    var score = [];
    var path = [];
    var n = arr.length;
    for (i = n - 1; i >= 0; i--) {
        path[i] = -1;
        score[i] = 1;
        for (j = i + 1; j < n; j++) {
            if (arr[j] > arr[i] && score[j] >= score[i]) {
                path[i] = j;
                score[i] = score[j] + 1;
            }
        }
    }

    var start = 0;
    var best = score[0];
    for (i = 1; i < n; i++) {
        if (score[i] > best) {
            start = i;
        }
    }

    for (i = start; i >= 0; i = path[i]) {
        console.log(i);
    }
    console.log("\n");
}
