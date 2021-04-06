import 'package:rare_pair/components/size_selector.dart';
import 'package:rare_pair/models/product_model.dart';
import 'package:flutter/material.dart';

const logos = [
  'assets/images/logo-adidas.png',
  'assets/images/logo-jordan-w.png',
  'assets/images/logo-nike-w.png',
  'assets/images/logo-off-white-w.png',
];

const image360 = [
  'assets/images/shoe/36.png',
  'assets/images/shoe/35.png',
  'assets/images/shoe/34.png',
  'assets/images/shoe/33.png',
  'assets/images/shoe/32.png',
  'assets/images/shoe/31.png',
  'assets/images/shoe/30.png',
  'assets/images/shoe/29.png',
  'assets/images/shoe/28.png',
  'assets/images/shoe/27.png',
  'assets/images/shoe/26.png',
  'assets/images/shoe/25.png',
  'assets/images/shoe/24.png',
  'assets/images/shoe/23.png',
  'assets/images/shoe/22.png',
  'assets/images/shoe/21.png',
  'assets/images/shoe/20.png',
  'assets/images/shoe/19.png',
  'assets/images/shoe/18.png',
  'assets/images/shoe/17.png',
  'assets/images/shoe/16.png',
  'assets/images/shoe/15.png',
  'assets/images/shoe/14.png',
  'assets/images/shoe/13.png',
  'assets/images/shoe/12.png',
  'assets/images/shoe/11.png',
  'assets/images/shoe/10.png',
  'assets/images/shoe/9.png',
  'assets/images/shoe/8.png',
  'assets/images/shoe/7.png',
  'assets/images/shoe/6.png',
  'assets/images/shoe/5.png',
  'assets/images/shoe/4.png',
  'assets/images/shoe/3.png',
  'assets/images/shoe/2.png',
  'assets/images/shoe/1.png',
];

final List<Product> productsx = [
  Product(
      name: 'Israfil',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/12/Sand-Taupe-360-1-300x212.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/12/Yeezy_Fade-360_36-300x212.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Natural',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/10/Natural-360-Photo-36-300x212.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Israfil',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/10/Israfil-360-36-300x212.png',
      logo: 'assets/images/logo-jordan-w.png'),
];

final List<Product> products2 = [
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/products/t1.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/products/t2.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/products/t3.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/products/t4.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/products/t5.png',
      logo: 'assets/images/logo-jordan-w.png'),
];

final List<Product> allProducts = [
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/shoes/1.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Israfil',
      price: '310.00',
      image: 'assets/images/shoes/6.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Neutral Grey (2020)',
      price: '310.00',
      image: 'assets/images/shoes/2.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Israfil',
      price: '310.00',
      image: 'assets/images/shoes/3.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Israfil',
      price: '310.00',
      image: 'assets/images/shoes/3.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/shoes/1.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
];
final List<Product> nike = [
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/shoes/1.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Neutral Grey (2020)',
      price: '310.00',
      image: 'assets/images/shoes/2.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Israfil',
      price: '310.00',
      image: 'assets/images/shoes/3.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Israfil',
      price: '310.00',
      image: 'assets/images/shoes/3.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image: 'assets/images/shoes/1.png',
      logo: 'assets/images/logo-jordan-w.png'),
];

final List<Product> adidas = [
  Product(
      name: 'Israfil',
      price: '310.00',
      image: 'assets/images/shoes/6.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Retro Union Guava Ice',
      price: '310.00',
      image: 'assets/images/shoes/7.png',
      logo: 'assets/images/logo-adidas.png'),
];

final watches = [
  Product(
      name: 'GA2100-1A1',
      price: '310',
      image: 'assets/images/watches/w4.png',
      logo: 'assets/images/logos/logo-gshock.png'),
  Product(
      name: 'Submariner 116610',
      price: '510',
      image: 'assets/images/watches/w3.png',
      logo: 'assets/images/logos/img-rolex.png'),
  Product(
      name: 'Series 5 GPS 40mm',
      price: '410',
      image: 'assets/images/watches/w1.png',
      logo: 'assets/images/logos/img-casio.png'),
  Product(
      name: 'Bape Black Camo',
      price: '210',
      image: 'assets/images/watches/w2.png',
      logo: 'assets/images/logos/img-rolex.png'),
];

final List<ProductSize> sizes = [
  ProductSize(name: '36', price: '420'),
  ProductSize(name: '36 2/3', price: '410'),
  ProductSize(name: '37 1/3', price: '390'),
  ProductSize(name: '38', price: '420'),
  ProductSize(name: '38 2/3', price: '320'),
  ProductSize(name: '39 1/3', price: '430'),
  ProductSize(name: '40', price: '450'),
  ProductSize(name: '40 2/3', price: '420'),
  ProductSize(name: '41 1/3', price: '410'),
  ProductSize(name: '42', price: '470'),
  ProductSize(name: '42 2/3', price: '490'),
  ProductSize(name: '43 1/3', price: '480'),
  ProductSize(name: '44', price: '400'),
  ProductSize(name: '44 2/3', price: '420'),
];

const imagesNetwork = [
  {
    "id": 160697,
    "name": "Yeezy Boost 350 V2 Antlia (Reflective)",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-35.png"
  },
  {
    "id": 160697,
    "name": "Yeezy Boost 350 V2 Antlia (Reflective)",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-35.png"
  },
  {
    "id": 160731,
    "name": "Antlia-Reflective-img360-34",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-34.png"
  },
  {
    "id": 160730,
    "name": "Antlia-Reflective-img360-33",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-33.png"
  },
  {
    "id": 160729,
    "name": "Antlia-Reflective-img360-32",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-32.png"
  },
  {
    "id": 160728,
    "name": "Antlia-Reflective-img360-31",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-31.png"
  },
  {
    "id": 160727,
    "name": "Antlia-Reflective-img360-30",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-30.png"
  },
  {
    "id": 160726,
    "name": "Antlia-Reflective-img360-29",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-29.png"
  },
  {
    "id": 160725,
    "name": "Antlia-Reflective-img360-28",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-28.png"
  },
  {
    "id": 160724,
    "name": "Antlia-Reflective-img360-27",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-27.png"
  },
  {
    "id": 160723,
    "name": "Antlia-Reflective-img360-26",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-26.png"
  },
  {
    "id": 160722,
    "name": "Antlia-Reflective-img360-25",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-25.png"
  },
  {
    "id": 160721,
    "name": "Antlia-Reflective-img360-24",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-24.png"
  },
  {
    "id": 160720,
    "name": "Antlia-Reflective-img360-23",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-23.png"
  },
  {
    "id": 160719,
    "name": "Antlia-Reflective-img360-22",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-22.png"
  },
  {
    "id": 160718,
    "name": "Antlia-Reflective-img360-21",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-21.png"
  },
  {
    "id": 160717,
    "name": "Antlia-Reflective-img360-20",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-20.png"
  },
  {
    "id": 160716,
    "name": "Antlia-Reflective-img360-19",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-19.png"
  },
  {
    "id": 160715,
    "name": "Antlia-Reflective-img360-18",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-18.png"
  },
  {
    "id": 160714,
    "name": "Antlia-Reflective-img360-17",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-17.png"
  },
  {
    "id": 160713,
    "name": "Antlia-Reflective-img360-16",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-16.png"
  },
  {
    "id": 160712,
    "name": "Antlia-Reflective-img360-15",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-15.png"
  },
  {
    "id": 160711,
    "name": "Antlia-Reflective-img360-14",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-14.png"
  },
  {
    "id": 160710,
    "name": "Antlia-Reflective-img360-13",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-13.png"
  },
  {
    "id": 160709,
    "name": "Antlia-Reflective-img360-12",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-12.png"
  },
  {
    "id": 160708,
    "name": "Antlia-Reflective-img360-11",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-11.png"
  },
  {
    "id": 160707,
    "name": "Antlia-Reflective-img360-10",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-10.png"
  },
  {
    "id": 160706,
    "name": "Antlia-Reflective-img360-09",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-09.png"
  },
  {
    "id": 160705,
    "name": "Antlia-Reflective-img360-08",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-08.png"
  },
  {
    "id": 160704,
    "name": "Antlia-Reflective-img360-07",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-07.png"
  },
  {
    "id": 160703,
    "name": "Antlia-Reflective-img360-06",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-06.png"
  },
  {
    "id": 160702,
    "name": "Antlia-Reflective-img360-05",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-05.png"
  },
  {
    "id": 160701,
    "name": "Antlia-Reflective-img360-04",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-04.png"
  },
  {
    "id": 160700,
    "name": "Antlia-Reflective-img360-03",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-03.png"
  },
  {
    "id": 160699,
    "name": "Antlia-Reflective-img360-02",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-02.png"
  },
  {
    "id": 160698,
    "name": "Antlia-Reflective-img360-01",
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-img360-01.png"
  }
];

const imagesNetworkReflective = [
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R35.png",
    "id": 0,
    "name": "0"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R34.png",
    "id": 1,
    "name": "1"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R33.png",
    "id": 2,
    "name": "2"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R32.png",
    "id": 3,
    "name": "3"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R31.png",
    "id": 4,
    "name": "4"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R30.png",
    "id": 5,
    "name": "5"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R29.png",
    "id": 6,
    "name": "6"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R28.png",
    "id": 7,
    "name": "7"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R27.png",
    "id": 8,
    "name": "8"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R26.png",
    "id": 9,
    "name": "9"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R25.png",
    "id": 10,
    "name": "10"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R24.png",
    "id": 11,
    "name": "11"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R23.png",
    "id": 12,
    "name": "12"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R22.png",
    "id": 13,
    "name": "13"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R21.png",
    "id": 14,
    "name": "14"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R20.png",
    "id": 15,
    "name": "15"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R19.png",
    "id": 16,
    "name": "16"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R18.png",
    "id": 17,
    "name": "17"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R17.png",
    "id": 18,
    "name": "18"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R16.png",
    "id": 19,
    "name": "19"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R15.png",
    "id": 20,
    "name": "20"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R14.png",
    "id": 21,
    "name": "21"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R13.png",
    "id": 22,
    "name": "22"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R12.png",
    "id": 23,
    "name": "23"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R11.png",
    "id": 24,
    "name": "24"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R10.png",
    "id": 25,
    "name": "25"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R09.png",
    "id": 26,
    "name": "26"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R08.png",
    "id": 27,
    "name": "27"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R07.png",
    "id": 28,
    "name": "28"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R06.png",
    "id": 29,
    "name": "29"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R05.png",
    "id": 30,
    "name": "30"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R04.png",
    "id": 31,
    "name": "31"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R03.png",
    "id": 32,
    "name": "32"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R02.png",
    "id": 33,
    "name": "33"
  },
  {
    "src":
        "https://kks-store.com/wp-content/uploads/2019/06/Antlia-Reflective-R01.png",
    "id": 34,
    "name": "34"
  }
];

final List<dynamic> homeData = [
  {
    "feature": "Featured",
    "product": "SNEAKERS",
    "logos": [
      'assets/images/logo-adidas.png',
      'assets/images/logo-jordan-w.png',
      'assets/images/logo-nike-w.png',
      'assets/images/logo-off-white-w.png',
    ],
    "products": [
      Product(
          name: 'Israfil',
          price: '310.00',
          image:
              'https://kks-store.com/wp-content/uploads/2020/12/Sand-Taupe-360-1-300x212.png',
          logo: 'assets/images/logo-jordan-w.png'),
      Product(
          name: 'Fade',
          price: '310.00',
          image:
              'https://kks-store.com/wp-content/uploads/2020/12/Yeezy_Fade-360_36-300x212.png',
          logo: 'assets/images/logo-adidas.png'),
      Product(
          name: 'Natural',
          price: '310.00',
          image:
              'https://kks-store.com/wp-content/uploads/2020/10/Natural-360-Photo-36-300x212.png',
          logo: 'assets/images/logo-jordan-w.png'),
      Product(
          name: 'Israfil',
          price: '310.00',
          image:
              'https://kks-store.com/wp-content/uploads/2020/10/Israfil-360-36-300x212.png',
          logo: 'assets/images/logo-jordan-w.png'),
    ]
  },
  {
    "feature": "Featured",
    "product": "WATCHES",
    "logos": [
      'assets/images/logos/logo-gshock.png',
      'assets/images/logos/img-rolex.png',
      'assets/images/logos/img-casio.png',
      'assets/images/logos/img-rolex.png',
    ],
    "products": [
      Product(
          name: 'GA2100-1A1',
          price: '310',
          image: 'assets/images/watches/w4.png',
          logo: 'assets/images/logos/logo-gshock.png'),
      Product(
          name: 'Submariner 116610',
          price: '510',
          image: 'assets/images/watches/w3.png',
          logo: 'assets/images/logos/img-rolex.png'),
      Product(
          name: 'Series 5 GPS 40mm',
          price: '410',
          image: 'assets/images/watches/w1.png',
          logo: 'assets/images/logos/img-casio.png'),
      Product(
          name: 'Bape Black Camo',
          price: '210',
          image: 'assets/images/watches/w2.png',
          logo: 'assets/images/logos/img-rolex.png'),
    ]
  },
  {
    "feature": "Featured",
    "product": "STREETWEAR",
    "logos": [
      'assets/images/logo-jordan-w.png',
      'assets/images/logo-adidas.png',
      'assets/images/logo-jordan-w.png',
      'assets/images/logo-jordan-w.png',
    ],
    "products": [
      Product(
          name: 'GA2100-1A1',
          price: '310',
          image: 'assets/images/products/t1.png',
          logo: 'assets/images/logos/logo-gshock.png'),
      Product(
          name: 'Submariner 116610',
          price: '510',
          image: 'assets/images/products/t2.png',
          logo: 'assets/images/logos/img-rolex.png'),
      Product(
          name: 'Series 5 GPS 40mm',
          price: '410',
          image: 'assets/images/products/t3.png',
          logo: 'assets/images/logos/img-casio.png'),
      Product(
          name: 'Bape Black Camo',
          price: '210',
          image: 'assets/images/products/t4.png',
          logo: 'assets/images/logos/img-rolex.png'),
      Product(
          name: 'Bape Black Camo',
          price: '210',
          image: 'assets/images/products/t5.png',
          logo: 'assets/images/logos/img-rolex.png'),
    ]
  }
];

List<Product> pcollect = [
  Product(
      name: 'GA2100-1A1',
      price: '310',
      image: 'assets/images/watches/w4.png',
      logo: 'assets/images/logos/logo-gshock.png'),
  Product(
      name: 'GA2100-1A1',
      price: '310',
      image: 'assets/images/products/t1.png',
      logo: 'assets/images/logos/logo-gshock.png'),
  Product(
      name: 'Natural',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/10/Natural-360-Photo-36-300x212.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Submariner 116610',
      price: '510',
      image: 'assets/images/watches/w3.png',
      logo: 'assets/images/logos/img-rolex.png'),
];

List<Product> pwshoes = [
  Product(
      name: 'Israfil',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/12/Sand-Taupe-360-1-300x212.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Fade',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/12/Yeezy_Fade-360_36-300x212.png',
      logo: 'assets/images/logo-adidas.png'),
  Product(
      name: 'Natural',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/10/Natural-360-Photo-36-300x212.png',
      logo: 'assets/images/logo-jordan-w.png'),
  Product(
      name: 'Israfil',
      price: '310.00',
      image:
          'https://kks-store.com/wp-content/uploads/2020/10/Israfil-360-36-300x212.png',
      logo: 'assets/images/logo-jordan-w.png'),
];

List<Product> pwatches = [
  Product(
      name: 'GA2100-1A1',
      price: '310',
      image: 'assets/images/watches/w4.png',
      logo: 'assets/images/logos/logo-gshock.png'),
  Product(
      name: 'Submariner 116610',
      price: '510',
      image: 'assets/images/watches/w3.png',
      logo: 'assets/images/logos/img-rolex.png'),
  Product(
      name: 'Series 5 GPS 40mm',
      price: '410',
      image: 'assets/images/watches/w1.png',
      logo: 'assets/images/logos/img-casio.png'),
  Product(
      name: 'Bape Black Camo',
      price: '210',
      image: 'assets/images/watches/w2.png',
      logo: 'assets/images/logos/img-rolex.png'),
];

List<Product> pstreet = [
  Product(
      name: 'GA2100-1A1',
      price: '310',
      image: 'assets/images/products/t1.png',
      logo: 'assets/images/logos/logo-gshock.png'),
  Product(
      name: 'Submariner 116610',
      price: '510',
      image: 'assets/images/products/t2.png',
      logo: 'assets/images/logos/img-rolex.png'),
  Product(
      name: 'Series 5 GPS 40mm',
      price: '410',
      image: 'assets/images/products/t3.png',
      logo: 'assets/images/logos/img-casio.png'),
  Product(
      name: 'Bape Black Camo',
      price: '210',
      image: 'assets/images/products/t4.png',
      logo: 'assets/images/logos/img-rolex.png'),
  Product(
      name: 'Bape Black Camo',
      price: '210',
      image: 'assets/images/products/t5.png',
      logo: 'assets/images/logos/img-rolex.png'),
];


var listSettings = [
    {
      "title": "AirPlane Mode",
      Icon: Icons.airplanemode_active,
      Color: Colors.orange,
      "text": "Switch"
    },
    {
      "title": "Wi-Fi",
      Icon: Icons.wifi,
      Color: Colors.blue,
      "text": "Solo Asia"
    },
    {
      "title": "Bluetooth",
      Icon: Icons.bluetooth,
      Color: Colors.blue,
      "text": "Not Connected"
    },
    {
      "title": "Cellular",
      Icon: Icons.online_prediction,
      Color: Colors.green,
      "text": "Off"
    },
    {
      "title": "Personal Hotspot",
      Icon: Icons.add_link,
      Color: Colors.green,
      "text": "Off"
    },
    {"title": "General", Icon: Icons.settings, Color: Colors.grey, "text": ""}
  ];

