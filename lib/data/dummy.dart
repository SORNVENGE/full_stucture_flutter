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
        name: 'Jordan 1 Retro High Turbo Green',
        price: '409.00',
        model: 'https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/air_jordan_1_turbo_green/offsets.json',
        image: 'https://kks-store.com/wp-content/uploads/2020/03/Air-Jordan-1-Retro-High-Turbo-Green.png',
        logo: 'assets/images/logo-jordan-w.png'),
      Product(
        name: 'Carbon Blue',
        price: '420.00',
        model: 'https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/yeezy_boost_700_carbon_blue/offsets.json',
        image: 'https://kks-store.com/wp-content/uploads/2019/12/Yeezy-Boost-700-Carbon-Blue.png',
        logo: 'assets/images/logo-adidas.png'),
      Product(
        name: 'Jordan 1 Retro High Turbo Green',
        price: '409.00',
        model: 'https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/air_jordan_1_turbo_green/offsets.json',
        image: 'https://kks-store.com/wp-content/uploads/2020/03/Air-Jordan-1-Retro-High-Turbo-Green.png',
        logo: 'assets/images/logo-jordan-w.png'),
      Product(
        name: 'Yecheil (Non-Reflective)',
        price: '310.00',
        model: 'https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/adidas_yeezy_350_yecheil/offsets.json',
        image: 'https://kks-store.com/wp-content/uploads/2019/12/Yecheil-1.png',
        logo: 'assets/images/logo-adidas.png'),
      Product(
        name: 'High Travis Scott',
        price: '1,123.00',
        model: 'https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/air_jordan_4_travis_scott/offsets.json',
        image: 'https://kks-store.com/wp-content/uploads/2020/03/Air-Jordan-1-Retro-High-Travis-Scott-300x212.png',
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

List<Map> listCountriesName = [
  {"name": "Afghanistan", "dial_code": "+93", "code": "AF"},
  {"name": "Aland Islands", "dial_code": "+358", "code": "AX"},
  {"name": "Albania", "dial_code": "+355", "code": "AL"},
  {"name": "Algeria", "dial_code": "+213", "code": "DZ"},
  {"name": "AmericanSamoa", "dial_code": "+1684", "code": "AS"},
  {"name": "Andorra", "dial_code": "+376", "code": "AD"},
  {"name": "Angola", "dial_code": "+244", "code": "AO"},
  {"name": "Anguilla", "dial_code": "+1264", "code": "AI"},
  {"name": "Antarctica", "dial_code": "+672", "code": "AQ"},
  {"name": "Antigua and Barbuda", "dial_code": "+1268", "code": "AG"},
  {"name": "Argentina", "dial_code": "+54", "code": "AR"},
  {"name": "Armenia", "dial_code": "+374", "code": "AM"},
  {"name": "Aruba", "dial_code": "+297", "code": "AW"},
  {"name": "Australia", "dial_code": "+61", "code": "AU"},
  {"name": "Austria", "dial_code": "+43", "code": "AT"},
  {"name": "Azerbaijan", "dial_code": "+994", "code": "AZ"},
  {"name": "Bahamas", "dial_code": "+1242", "code": "BS"},
  {"name": "Bahrain", "dial_code": "+973", "code": "BH"},
  {"name": "Bangladesh", "dial_code": "+880", "code": "BD"},
  {"name": "Barbados", "dial_code": "+1246", "code": "BB"},
  {"name": "Belarus", "dial_code": "+375", "code": "BY"},
  {"name": "Belgium", "dial_code": "+32", "code": "BE"},
  {"name": "Belize", "dial_code": "+501", "code": "BZ"},
  {"name": "Benin", "dial_code": "+229", "code": "BJ"},
  {"name": "Bermuda", "dial_code": "+1441", "code": "BM"},
  {"name": "Bhutan", "dial_code": "+975", "code": "BT"},
  {
    "name": "Bolivia, Plurinational State of",
    "dial_code": "+591",
    "code": "BO"
  },
  {"name": "Bosnia and Herzegovina", "dial_code": "+387", "code": "BA"},
  {"name": "Botswana", "dial_code": "+267", "code": "BW"},
  {"name": "Brazil", "dial_code": "+55", "code": "BR"},
  {"name": "British Indian Ocean Territory", "dial_code": "+246", "code": "IO"},
  {"name": "Brunei Darussalam", "dial_code": "+673", "code": "BN"},
  {"name": "Bulgaria", "dial_code": "+359", "code": "BG"},
  {"name": "Burkina Faso", "dial_code": "+226", "code": "BF"},
  {"name": "Burundi", "dial_code": "+257", "code": "BI"},
  {"name": "Cambodia", "dial_code": "+855", "code": "KH"},
  {"name": "Cameroon", "dial_code": "+237", "code": "CM"},
  {"name": "Canada", "dial_code": "+1", "code": "CA"},
  {"name": "Cape Verde", "dial_code": "+238", "code": "CV"},
  {"name": "Cayman Islands", "dial_code": "+ 345", "code": "KY"},
  {"name": "Central African Republic", "dial_code": "+236", "code": "CF"},
  {"name": "Chad", "dial_code": "+235", "code": "TD"},
  {"name": "Chile", "dial_code": "+56", "code": "CL"},
  {"name": "China", "dial_code": "+86", "code": "CN"},
  {"name": "Christmas Island", "dial_code": "+61", "code": "CX"},
  {"name": "Cocos (Keeling) Islands", "dial_code": "+61", "code": "CC"},
  {"name": "Colombia", "dial_code": "+57", "code": "CO"},
  {"name": "Comoros", "dial_code": "+269", "code": "KM"},
  {"name": "Congo", "dial_code": "+242", "code": "CG"},
  {
    "name": "Congo, The Democratic Republic of the Congo",
    "dial_code": "+243",
    "code": "CD"
  },
  {"name": "Cook Islands", "dial_code": "+682", "code": "CK"},
  {"name": "Costa Rica", "dial_code": "+506", "code": "CR"},
  {"name": "Cote d'Ivoire", "dial_code": "+225", "code": "CI"},
  {"name": "Croatia", "dial_code": "+385", "code": "HR"},
  {"name": "Cuba", "dial_code": "+53", "code": "CU"},
  {"name": "Cyprus", "dial_code": "+357", "code": "CY"},
  {"name": "Czech Republic", "dial_code": "+420", "code": "CZ"},
  {"name": "Denmark", "dial_code": "+45", "code": "DK"},
  {"name": "Djibouti", "dial_code": "+253", "code": "DJ"},
  {"name": "Dominica", "dial_code": "+1767", "code": "DM"},
  {"name": "Dominican Republic", "dial_code": "+1849", "code": "DO"},
  {"name": "Ecuador", "dial_code": "+593", "code": "EC"},
  {"name": "Egypt", "dial_code": "+20", "code": "EG"},
  {"name": "El Salvador", "dial_code": "+503", "code": "SV"},
  {"name": "Equatorial Guinea", "dial_code": "+240", "code": "GQ"},
  {"name": "Eritrea", "dial_code": "+291", "code": "ER"},
  {"name": "Estonia", "dial_code": "+372", "code": "EE"},
  {"name": "Ethiopia", "dial_code": "+251", "code": "ET"},
  {"name": "Falkland Islands (Malvinas)", "dial_code": "+500", "code": "FK"},
  {"name": "Faroe Islands", "dial_code": "+298", "code": "FO"},
  {"name": "Fiji", "dial_code": "+679", "code": "FJ"},
  {"name": "Finland", "dial_code": "+358", "code": "FI"},
  {"name": "France", "dial_code": "+33", "code": "FR"},
  {"name": "French Guiana", "dial_code": "+594", "code": "GF"},
  {"name": "French Polynesia", "dial_code": "+689", "code": "PF"},
  {"name": "Gabon", "dial_code": "+241", "code": "GA"},
  {"name": "Gambia", "dial_code": "+220", "code": "GM"},
  {"name": "Georgia", "dial_code": "+995", "code": "GE"},
  {"name": "Germany", "dial_code": "+49", "code": "DE"},
  {"name": "Ghana", "dial_code": "+233", "code": "GH"},
  {"name": "Gibraltar", "dial_code": "+350", "code": "GI"},
  {"name": "Greece", "dial_code": "+30", "code": "GR"},
  {"name": "Greenland", "dial_code": "+299", "code": "GL"},
  {"name": "Grenada", "dial_code": "+1473", "code": "GD"},
  {"name": "Guadeloupe", "dial_code": "+590", "code": "GP"},
  {"name": "Guam", "dial_code": "+1671", "code": "GU"},
  {"name": "Guatemala", "dial_code": "+502", "code": "GT"},
  {"name": "Guernsey", "dial_code": "+44", "code": "GG"},
  {"name": "Guinea", "dial_code": "+224", "code": "GN"},
  {"name": "Guinea-Bissau", "dial_code": "+245", "code": "GW"},
  {"name": "Guyana", "dial_code": "+595", "code": "GY"},
  {"name": "Haiti", "dial_code": "+509", "code": "HT"},
  {"name": "Holy See (Vatican City State)", "dial_code": "+379", "code": "VA"},
  {"name": "Honduras", "dial_code": "+504", "code": "HN"},
  {"name": "Hong Kong", "dial_code": "+852", "code": "HK"},
  {"name": "Hungary", "dial_code": "+36", "code": "HU"},
  {"name": "Iceland", "dial_code": "+354", "code": "IS"},
  {"name": "India", "dial_code": "+91", "code": "IN"},
  {"name": "Indonesia", "dial_code": "+62", "code": "ID"},
  {
    "name": "Iran, Islamic Republic of Persian Gulf",
    "dial_code": "+98",
    "code": "IR"
  },
  {"name": "Iraq", "dial_code": "+964", "code": "IQ"},
  {"name": "Ireland", "dial_code": "+353", "code": "IE"},
  {"name": "Isle of Man", "dial_code": "+44", "code": "IM"},
  {"name": "Israel", "dial_code": "+972", "code": "IL"},
  {"name": "Italy", "dial_code": "+39", "code": "IT"},
  {"name": "Jamaica", "dial_code": "+1876", "code": "JM"},
  {"name": "Japan", "dial_code": "+81", "code": "JP"},
  {"name": "Jersey", "dial_code": "+44", "code": "JE"},
  {"name": "Jordan", "dial_code": "+962", "code": "JO"},
  {"name": "Kazakhstan", "dial_code": "+77", "code": "KZ"},
  {"name": "Kenya", "dial_code": "+254", "code": "KE"},
  {"name": "Kiribati", "dial_code": "+686", "code": "KI"},
  {
    "name": "Korea, Democratic People's Republic of Korea",
    "dial_code": "+850",
    "code": "KP"
  },
  {"name": "Korea, Republic of South Korea", "dial_code": "+82", "code": "KR"},
  {"name": "Kuwait", "dial_code": "+965", "code": "KW"},
  {"name": "Kyrgyzstan", "dial_code": "+996", "code": "KG"},
  {"name": "Laos", "dial_code": "+856", "code": "LA"},
  {"name": "Latvia", "dial_code": "+371", "code": "LV"},
  {"name": "Lebanon", "dial_code": "+961", "code": "LB"},
  {"name": "Lesotho", "dial_code": "+266", "code": "LS"},
  {"name": "Liberia", "dial_code": "+231", "code": "LR"},
  {"name": "Libyan Arab Jamahiriya", "dial_code": "+218", "code": "LY"},
  {"name": "Liechtenstein", "dial_code": "+423", "code": "LI"},
  {"name": "Lithuania", "dial_code": "+370", "code": "LT"},
  {"name": "Luxembourg", "dial_code": "+352", "code": "LU"},
  {"name": "Macao", "dial_code": "+853", "code": "MO"},
  {"name": "Macedonia", "dial_code": "+389", "code": "MK"},
  {"name": "Madagascar", "dial_code": "+261", "code": "MG"},
  {"name": "Malawi", "dial_code": "+265", "code": "MW"},
  {"name": "Malaysia", "dial_code": "+60", "code": "MY"},
  {"name": "Maldives", "dial_code": "+960", "code": "MV"},
  {"name": "Mali", "dial_code": "+223", "code": "ML"},
  {"name": "Malta", "dial_code": "+356", "code": "MT"},
  {"name": "Marshall Islands", "dial_code": "+692", "code": "MH"},
  {"name": "Martinique", "dial_code": "+596", "code": "MQ"},
  {"name": "Mauritania", "dial_code": "+222", "code": "MR"},
  {"name": "Mauritius", "dial_code": "+230", "code": "MU"},
  {"name": "Mayotte", "dial_code": "+262", "code": "YT"},
  {"name": "Mexico", "dial_code": "+52", "code": "MX"},
  {
    "name": "Micronesia, Federated States of Micronesia",
    "dial_code": "+691",
    "code": "FM"
  },
  {"name": "Moldova", "dial_code": "+373", "code": "MD"},
  {"name": "Monaco", "dial_code": "+377", "code": "MC"},
  {"name": "Mongolia", "dial_code": "+976", "code": "MN"},
  {"name": "Montenegro", "dial_code": "+382", "code": "ME"},
  {"name": "Montserrat", "dial_code": "+1664", "code": "MS"},
  {"name": "Morocco", "dial_code": "+212", "code": "MA"},
  {"name": "Mozambique", "dial_code": "+258", "code": "MZ"},
  {"name": "Myanmar", "dial_code": "+95", "code": "MM"},
  {"name": "Namibia", "dial_code": "+264", "code": "NA"},
  {"name": "Nauru", "dial_code": "+674", "code": "NR"},
  {"name": "Nepal", "dial_code": "+977", "code": "NP"},
  {"name": "Netherlands", "dial_code": "+31", "code": "NL"},
  {"name": "Netherlands Antilles", "dial_code": "+599", "code": "AN"},
  {"name": "New Caledonia", "dial_code": "+687", "code": "NC"},
  {"name": "New Zealand", "dial_code": "+64", "code": "NZ"},
  {"name": "Nicaragua", "dial_code": "+505", "code": "NI"},
  {"name": "Niger", "dial_code": "+227", "code": "NE"},
  {"name": "Nigeria", "dial_code": "+234", "code": "NG"},
  {"name": "Niue", "dial_code": "+683", "code": "NU"},
  {"name": "Norfolk Island", "dial_code": "+672", "code": "NF"},
  {"name": "Northern Mariana Islands", "dial_code": "+1670", "code": "MP"},
  {"name": "Norway", "dial_code": "+47", "code": "NO"},
  {"name": "Oman", "dial_code": "+968", "code": "OM"},
  {"name": "Pakistan", "dial_code": "+92", "code": "PK"},
  {"name": "Palau", "dial_code": "+680", "code": "PW"},
  {
    "name": "Palestinian Territory, Occupied",
    "dial_code": "+970",
    "code": "PS"
  },
  {"name": "Panama", "dial_code": "+507", "code": "PA"},
  {"name": "Papua New Guinea", "dial_code": "+675", "code": "PG"},
  {"name": "Paraguay", "dial_code": "+595", "code": "PY"},
  {"name": "Peru", "dial_code": "+51", "code": "PE"},
  {"name": "Philippines", "dial_code": "+63", "code": "PH"},
  {"name": "Pitcairn", "dial_code": "+872", "code": "PN"},
  {"name": "Poland", "dial_code": "+48", "code": "PL"},
  {"name": "Portugal", "dial_code": "+351", "code": "PT"},
  {"name": "Puerto Rico", "dial_code": "+1939", "code": "PR"},
  {"name": "Qatar", "dial_code": "+974", "code": "QA"},
  {"name": "Romania", "dial_code": "+40", "code": "RO"},
  {"name": "Russia", "dial_code": "+7", "code": "RU"},
  {"name": "Rwanda", "dial_code": "+250", "code": "RW"},
  {"name": "Reunion", "dial_code": "+262", "code": "RE"},
  {"name": "Saint Barthelemy", "dial_code": "+590", "code": "BL"},
  {
    "name": "Saint Helena, Ascension and Tristan Da Cunha",
    "dial_code": "+290",
    "code": "SH"
  },
  {"name": "Saint Kitts and Nevis", "dial_code": "+1869", "code": "KN"},
  {"name": "Saint Lucia", "dial_code": "+1758", "code": "LC"},
  {"name": "Saint Martin", "dial_code": "+590", "code": "MF"},
  {"name": "Saint Pierre and Miquelon", "dial_code": "+508", "code": "PM"},
  {
    "name": "Saint Vincent and the Grenadines",
    "dial_code": "+1784",
    "code": "VC"
  },
  {"name": "Samoa", "dial_code": "+685", "code": "WS"},
  {"name": "San Marino", "dial_code": "+378", "code": "SM"},
  {"name": "Sao Tome and Principe", "dial_code": "+239", "code": "ST"},
  {"name": "Saudi Arabia", "dial_code": "+966", "code": "SA"},
  {"name": "Senegal", "dial_code": "+221", "code": "SN"},
  {"name": "Serbia", "dial_code": "+381", "code": "RS"},
  {"name": "Seychelles", "dial_code": "+248", "code": "SC"},
  {"name": "Sierra Leone", "dial_code": "+232", "code": "SL"},
  {"name": "Singapore", "dial_code": "+65", "code": "SG"},
  {"name": "Slovakia", "dial_code": "+421", "code": "SK"},
  {"name": "Slovenia", "dial_code": "+386", "code": "SI"},
  {"name": "Solomon Islands", "dial_code": "+677", "code": "SB"},
  {"name": "Somalia", "dial_code": "+252", "code": "SO"},
  {"name": "South Africa", "dial_code": "+27", "code": "ZA"},
  {"name": "South Sudan", "dial_code": "+211", "code": "SS"},
  {
    "name": "South Georgia and the South Sandwich Islands",
    "dial_code": "+500",
    "code": "GS"
  },
  {"name": "Spain", "dial_code": "+34", "code": "ES"},
  {"name": "Sri Lanka", "dial_code": "+94", "code": "LK"},
  {"name": "Sudan", "dial_code": "+249", "code": "SD"},
  {"name": "Suriname", "dial_code": "+597", "code": "SR"},
  {"name": "Svalbard and Jan Mayen", "dial_code": "+47", "code": "SJ"},
  {"name": "Swaziland", "dial_code": "+268", "code": "SZ"},
  {"name": "Sweden", "dial_code": "+46", "code": "SE"},
  {"name": "Switzerland", "dial_code": "+41", "code": "CH"},
  {"name": "Syrian Arab Republic", "dial_code": "+963", "code": "SY"},
  {"name": "Taiwan", "dial_code": "+886", "code": "TW"},
  {"name": "Tajikistan", "dial_code": "+992", "code": "TJ"},
  {
    "name": "Tanzania, United Republic of Tanzania",
    "dial_code": "+255",
    "code": "TZ"
  },
  {"name": "Thailand", "dial_code": "+66", "code": "TH"},
  {"name": "Timor-Leste", "dial_code": "+670", "code": "TL"},
  {"name": "Togo", "dial_code": "+228", "code": "TG"},
  {"name": "Tokelau", "dial_code": "+690", "code": "TK"},
  {"name": "Tonga", "dial_code": "+676", "code": "TO"},
  {"name": "Trinidad and Tobago", "dial_code": "+1868", "code": "TT"},
  {"name": "Tunisia", "dial_code": "+216", "code": "TN"},
  {"name": "Turkey", "dial_code": "+90", "code": "TR"},
  {"name": "Turkmenistan", "dial_code": "+993", "code": "TM"},
  {"name": "Turks and Caicos Islands", "dial_code": "+1649", "code": "TC"},
  {"name": "Tuvalu", "dial_code": "+688", "code": "TV"},
  {"name": "Uganda", "dial_code": "+256", "code": "UG"},
  {"name": "Ukraine", "dial_code": "+380", "code": "UA"},
  {"name": "United Arab Emirates", "dial_code": "+971", "code": "AE"},
  {"name": "United Kingdom", "dial_code": "+44", "code": "GB"},
  {"name": "United States", "dial_code": "+1", "code": "US"},
  {"name": "Uruguay", "dial_code": "+598", "code": "UY"},
  {"name": "Uzbekistan", "dial_code": "+998", "code": "UZ"},
  {"name": "Vanuatu", "dial_code": "+678", "code": "VU"},
  {
    "name": "Venezuela, Bolivarian Republic of Venezuela",
    "dial_code": "+58",
    "code": "VE"
  },
  {"name": "Vietnam", "dial_code": "+84", "code": "VN"},
  {"name": "Virgin Islands, British", "dial_code": "+1284", "code": "VG"},
  {"name": "Virgin Islands, U.S.", "dial_code": "+1340", "code": "VI"},
  {"name": "Wallis and Futuna", "dial_code": "+681", "code": "WF"},
  {"name": "Yemen", "dial_code": "+967", "code": "YE"},
  {"name": "Zambia", "dial_code": "+260", "code": "ZM"},
  {"name": "Zimbabwe", "dial_code": "+263", "code": "ZW"}
];

