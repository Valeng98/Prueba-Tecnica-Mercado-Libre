# Prueba Técnica Meli iOS Dev por (Valentina Guarnizo).
### Swift V.5 - Xcode 13.0

<h2 align="left">
  Meli App
</h2>

<p align="left">
  GitHub iOS client, in MVVM-R.
</p>

## Basic, App Features
- [x] Mercado Libre [Api](https://developers.mercadolibre.com.ar/es_ar/items-y-busquedas)

* **App**
- [x] Home
- [x] Serach
- [x] Detalle
- [x] Record

## Technologies
- [x] Xcode
- [x] Swift, architecture (MVVM-R)
- [x] third-party dependency managers ([Cocoapods](https://cocoapods.org/))

## Tools
- [x] [SkeletonView](https://github.com/Juanpe/SkeletonView) - Has been conceived to address this need, an elegant way to show users that something is happening and also prepare them for which contents are waiting.

## Communication layers VIPER
![alt text](https://github.com/Valeng98/Prueba-Tecnica-Mercado-Libre/blob/main/Diagrama-MVVM.png?raw=true)

- [x] MVVM Layered communication using protocols

```swift
//MARK: Roter Protocol
protocol RecordRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    
    static func createModule(selectRecord: @escaping ((String) -> Void)) -> RecordViewController
}

//MARK: View Protocol
protocol RecordViewProtocol: AnyObject {
    var viewModel: RecordViewModelProtocol? { get set }
}

//MARK: ViewModel Protocol
protocol RecordViewModelProtocol: AnyObject {
    var view: RecordViewProtocol? { get set }
    var router: RecordRouterProtocol? { get set }   
}
```
## Evidence
<img src="https://github.com/Valeng98/Prueba-Tecnica-Mercado-Libre/blob/main/Evidencia.gif" width="250"/>

<img src="https://github.com/Valeng98/Prueba-Tecnica-Mercado-Libre/blob/main/Evidencia-Error.gif" width="250"/>


