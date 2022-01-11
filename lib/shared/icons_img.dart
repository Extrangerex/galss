import 'package:flutter/cupertino.dart';

enum CustomIconImg { icCatalogo, icCercaDeMi, icConexiones, icMiPerfil }

ImageProvider iconImg({required CustomIconImg customIconImg}) {
  switch (customIconImg) {
    case CustomIconImg.icCatalogo:
      return const AssetImage('assets/images/ic_catalogo.png');
    case CustomIconImg.icCercaDeMi:
      return const AssetImage('assets/images/ic_cerca_mi.png');
    case CustomIconImg.icConexiones:
      return const AssetImage('assets/images/ic_conexiones.png');
    case CustomIconImg.icMiPerfil:
      return const AssetImage('assets/images/ic_miperfil.png');
  }
}
