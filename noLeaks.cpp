void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId) {
    //Create a boolean to keep track of whether we created a player object
    bool createdPlayer = false;
    Player* player = g_game.getPlayerByName(recipient);

    // Create a new player object if the player does not exist
    if (!player) {
        //This object is dynamically allocated and must be deleted later!
        //Alternatively you can use smart pointers to manage memory
        player = new Player(nullptr);
        //Make sure we know that we created the player object
        createdPlayer = true;

        // Try to load player data
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            // Properly delete player object if loading fails
            delete player;  
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (createdPlayer) {
            delete player;  // Delete player if item creation fails
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    // Handle player save if the player was offline and we created the player dynamically
    if (createdPlayer && player->isOffline()) {
        IOLoginData::savePlayer(player);
        delete player;  // After saving delete the dynamic player object
    }
}