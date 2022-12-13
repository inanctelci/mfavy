class Mp3Model {
  Mp3Model({
    required this.guid,
    required this.message,
    required this.file,
    required this.youtubeAPI,
  });
  late final String guid;
  late final String message;
  late final String file;
  late final YoutubeAPI youtubeAPI;

  Mp3Model.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    message = json['message'];
    file = json['file'];
    youtubeAPI = YoutubeAPI.fromJson(json['YoutubeAPI']);
  }
}

class YoutubeAPI {
  YoutubeAPI({
    required this.id,
    required this.definizione,
    required this.contatoreVisualizzazioni,
    required this.descrizione,
    required this.titolo,
    required this.dataPubblicazione,
    required this.thumbUrl,
    required this.licenza,
    required this.durataVideo,
    required this.durationOriginal,
    required this.counter,
    this.paesi,
    required this.urlMp3,
    required this.urlVideo,
  });
  late final String id;
  late final String definizione;
  late final String contatoreVisualizzazioni;
  late final String descrizione;
  late final String titolo;
  late final String dataPubblicazione;
  late final String thumbUrl;
  late final String licenza;
  late final String durataVideo;
  late final String durationOriginal;
  late final int counter;
  late final Null paesi;
  late final String urlMp3;
  late final bool urlVideo;

  YoutubeAPI.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    definizione = json['definizione'];
    contatoreVisualizzazioni = json['contatore_visualizzazioni'];
    descrizione = json['descrizione'];
    titolo = json['titolo'];
    dataPubblicazione = json['data_pubblicazione'];
    thumbUrl = json['thumbUrl'];
    licenza = json['licenza'];
    durataVideo = json['durata_video'];
    durationOriginal = json['duration_original'];
    counter = json['counter'];
    paesi = null;
    urlMp3 = json['urlMp3'];
    urlVideo = json['urlVideo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['definizione'] = definizione;
    data['contatore_visualizzazioni'] = contatoreVisualizzazioni;
    data['descrizione'] = descrizione;
    data['titolo'] = titolo;
    data['data_pubblicazione'] = dataPubblicazione;
    data['thumbUrl'] = thumbUrl;
    data['licenza'] = licenza;
    data['durata_video'] = durataVideo;
    data['duration_original'] = durationOriginal;
    data['counter'] = counter;
    data['paesi'] = paesi;
    data['urlMp3'] = urlMp3;
    data['urlVideo'] = urlVideo;
    return data;
  }
}
