<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ale Gry – Gry Przeglądarkowe Tworzone przez AI</title>
    <style>
        :root {
            --bg-color: #0f172a;
            --card-bg: #1e293b;
            --text-color: #f8fafc;
            --text-muted: #94a3b8;
            --accent-color: #8b5cf6;
            --accent-hover: #7c3aed;
            --border-color: #334155;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background-color: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--text-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo span {
            color: var(--accent-color);
        }

        .badge {
            background: linear-gradient(135deg, #8b5cf6, #ec4899);
            font-size: 0.75rem;
            padding: 0.2rem 0.6rem;
            border-radius: 20px;
            text-transform: uppercase;
            font-weight: bold;
        }

        .controls {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        input[type="text"] {
            background-color: var(--bg-color);
            border: 1px solid var(--border-color);
            color: var(--text-color);
            padding: 0.6rem 1rem;
            border-radius: 8px;
            outline: none;
            width: 220px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus {
            border-color: var(--accent-color);
        }

        .btn {
            background-color: var(--accent-color);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.1s;
        }

        .btn:hover {
            background-color: var(--accent-hover);
        }

        .btn:active {
            transform: scale(0.98);
        }

        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            flex-grow: 1;
            width: 100%;
        }

        .hero {
            text-align: center;
            margin-bottom: 3rem;
        }

        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .hero p {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        /* Sekcja Dodawania Gry */
        .add-game-panel {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2.5rem;
            display: none;
        }

        .add-game-panel.active {
            display: block;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.4rem;
        }

        .form-group label {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .form-group input, .form-group select {
            background-color: var(--bg-color);
            border: 1px solid var(--border-color);
            color: var(--text-color);
            padding: 0.6rem;
            border-radius: 6px;
            outline: none;
        }

        /* Siatka gier */
        .games-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 1.5rem;
        }

        .game-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }

        .game-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
            border-color: var(--accent-color);
        }

        .card-thumb {
            width: 100%;
            height: 160px;
            background-color: #334155;
            object-fit: cover;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-weight: bold;
        }

        .card-body {
            padding: 1.2rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .card-title {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 0.4rem;
        }

        .card-category {
            font-size: 0.75rem;
            color: var(--accent-color);
            text-transform: uppercase;
            font-weight: bold;
            margin-bottom: 0.6rem;
        }

        .card-desc {
            font-size: 0.9rem;
            color: var(--text-muted);
            line-height: 1.4;
            flex-grow: 1;
            margin-bottom: 1rem;
        }

        /* Modal odtwarzacza gry */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.85);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            padding: 1rem;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background-color: var(--card-bg);
            border-radius: 12px;
            width: 100%;
            max-width: 900px;
            height: 80vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .modal-header {
            padding: 1rem;
            background-color: var(--bg-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-close {
            background: none;
            border: none;
            color: var(--text-color);
            font-size: 1.5rem;
            cursor: pointer;
        }

        .modal-body {
            flex-grow: 1;
            background-color: #000;
        }

        .modal-body iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        footer {
            text-align: center;
            padding: 2rem;
            color: var(--text-muted);
            border-top: 1px solid var(--border-color);
            margin-top: auto;
        }
    </style>
</head>
<body>

    <header>
        <a href="#" class="logo">Ale <span>Gry</span> <span class="badge">AI</span></a>
        <div class="controls">
            <input type="text" id="searchInput" placeholder="Szukaj gry..." oninput="filterGames()">
            <button class="btn" onclick="toggleAddPanel()">+ Dodaj grę</button>
        </div>
    </header>

    <main>
        <section class="hero">
            <h1>Odkrywaj gry generowane przez sztuczną inteligencję</h1>
            <p>Zagraj w unikalne tytuły wygenerowane przez AI bezpośrednio w przeglądarce.</p>
        </section>

        <!-- Formularz dodawania nowej gry -->
        <section class="add-game-panel" id="addGamePanel">
            <h2 style="margin-bottom: 1rem;">Dodaj nową grę AI</h2>
            <form id="gameForm" onsubmit="saveGame(event)">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Tytuł gry</label>
                        <input type="text" id="gameTitle" required placeholder="np. Cyber Runner AI">
                    </div>
                    <div class="form-group">
                        <label>Kategoria</label>
                        <select id="gameCategory">
                            <option value="Arcade">Arcade</option>
                            <option value="Logiczne">Logiczne</option>
                            <option value="Akcja">Akcja</option>
                            <option value="RPG">RPG</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>URL miniaturki (obrazka)</label>
                        <input type="url" id="gameThumb" placeholder="https://..." required>
                    </div>
                    <div class="form-group">
                        <label>URL gry (HTML lub plik)</label>
                        <input type="url" id="gameUrl" placeholder="https://..." required>
                    </div>
                </div>
                <div class="form-group" style="margin-bottom: 1rem;">
                    <label>Krótki opis</label>
                    <input type="text" id="gameDesc" required placeholder="Opisz sterowanie lub fabułę...">
                </div>
                <button type="submit" class="btn">Opublikuj grę</button>
            </form>
        </section>

        <!-- Lista gier -->
        <section class="games-grid" id="gamesContainer">
            <!-- Gry będą wstawiane tutaj dynamicznie z JS -->
        </section>
    </main>

    <!-- Modal Odtwarzacza -->
    <div class="modal" id="gameModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Tytuł Gry</h3>
                <button class="modal-close" onclick="closeGame()">&times;</button>
            </div>
            <div class="modal-body">
                <iframe id="gameIframe" src="" allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Ale Gry. Wszystkie gry stworzone przy użyciu modeli AI.</p>
    </footer>

    <script>
        // Domyślna lista gier przykładowych
        const defaultGames = [
            {
                id: 1,
                title: "AI Space Shooter",
                category: "Arcade",
                thumb: "https://picsum.photos/300/200?random=1",
                url: "https://example.com", 
                desc: "Klasyczna strzelanka kosmiczna wygenerowana w całości przez Claude 3.5 Sonnet."
            },
            {
                id: 2,
                title: "Neon Labyrinth",
                category: "Logiczne",
                thumb: "https://picsum.photos/300/200?random=2",
                url: "https://example.com",
                desc: "Proceduralnie generowany labirynt neonowy stworzony z pomocą GPT-4o."
            }
        ];

        // Pobieranie gier z pamięci lokalnej przeglądarki (localStorage)
        let games = JSON.parse(localStorage.getItem('aleGryData')) || defaultGames;

        function renderGames(dataToRender = games) {
            const container = document.getElementById('gamesContainer');
            container.innerHTML = '';

            if (dataToRender.length === 0) {
                container.innerHTML = '<p style="grid-column: 1/-1; text-align: center; color: var(--text-muted);">Brak gier do wyświetlenia.</p>';
                return;
            }

            dataToRender.forEach(game => {
                const card = document.createElement('div');
                card.className = 'game-card';
                card.onclick = () => openGame(game.title, game.url);
                card.innerHTML = `
                    <img src="${game.thumb}" alt="${game.title}" class="card-thumb" onerror="this.src='https://via.placeholder.com/300x200?text=Brak+Obrazu'">
                    <div class="card-body">
                        <span class="card-category">${game.category}</span>
                        <h3 class="card-title">${game.title}</h3>
                        <p class="card-desc">${game.desc}</p>
                        <button class="btn" style="width: 100%;">Zagraj teraz</button>
                    </div>
                `;
                container.appendChild(card);
            });
        }

        function toggleAddPanel() {
            const panel = document.getElementById('addGamePanel');
            panel.classList.toggle('active');
        }

        function saveGame(event) {
            event.preventDefault();

            const newGame = {
                id: Date.now(),
                title: document.getElementById('gameTitle').value,
                category: document.getElementById('gameCategory').value,
                thumb: document.getElementById('gameThumb').value,
                url: document.getElementById('gameUrl').value,
                desc: document.getElementById('gameDesc').value
            };

            games.unshift(newGame);
            localStorage.setItem('aleGryData', JSON.stringify(games));
            
            renderGames();
            document.getElementById('gameForm').reset();
            toggleAddPanel();
        }

        function filterGames() {
            const query = document.getElementById('searchInput').value.toLowerCase();
            const filtered = games.filter(game => 
                game.title.toLowerCase().includes(query) || 
                game.desc.toLowerCase().includes(query) ||
                game.category.toLowerCase().includes(query)
            );
            renderGames(filtered);
        }

        function openGame(title, url) {
            document.getElementById('modalTitle').innerText = title;
            document.getElementById('gameIframe').src = url;
            document.getElementById('gameModal').classList.add('active');
        }

        function closeGame() {
            document.getElementById('gameModal').classList.remove('active');
            document.getElementById('gameIframe').src = '';
        }

        // Pierwsze renderowanie po załadowaniu strony
        renderGames();
    </script>
</body>
</html>
