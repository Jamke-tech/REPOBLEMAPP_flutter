class Chat {
  final String offerName, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.offerName,
    this.lastMessage,
    this.image,
    this.time,
    this.isActive,
  });
}


//probar si va a codigo
List chatsData = [
  Chat(
    offerName: "Casa de Ferrador",
    lastMessage: "Molt bé, ens veiem demà",
    image: "assets/images/lleida.jpg",
    time: "3m abans",
    isActive: true,

  ),
  Chat(
    offerName: "Casa de Ferrador",
    lastMessage: "Molt bé, ens veiem demà",
    image: "assets/images/barcelona.jpg",
    time: "3m abans",
    isActive: false,
  )
];