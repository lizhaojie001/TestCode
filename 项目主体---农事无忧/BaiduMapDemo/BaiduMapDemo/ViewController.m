//
//  ViewController.m
//  BaiduMapDemo
//
//  Created by Mac on 17/1/3.
//  Copyright © 2017年 HBNXWLKJ. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface ViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate >{
    IBOutlet  BMKMapView * _mapView;
    BMKLocationService* _locService;
    BMKGeoCodeSearch * _geocodesearch;
    BMKGroundOverlay* ground2;
    BMKGroundOverlay* ground;
    
    BMKPolygon* polygon2;
    BMKPointAnnotation* pointAnnotation;
    
    __weak IBOutlet UITextField *addressT;
    __weak IBOutlet UITextField *cityT;
    __weak IBOutlet UILabel *latitudeLabel;
    
    __weak IBOutlet UILabel *longitudeLabel;
}

@end

@implementation ViewController
- (IBAction)switchSatelliteType:(UIButton *)sender {
    _mapView.mapType=  _mapView.mapType == BMKMapTypeSatellite?BMKMapTypeStandard:BMKMapTypeSatellite;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy = 1.0;
    _locService.distanceFilter =1.0;
    _mapView.mapType = BMKMapTypeStandard;
    // [_mapView setBaiduHeatMapEnabled:YES];
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    latitude =  30.707913;
    longitude =114.508186;
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longitude);	///< 中心点经纬度坐标
    CLLocationDegrees latitudeDelta = 0.01;	///< 纬度范围
    CLLocationDegrees longitudeDelta = 0.01;	///< 经度范围
    BMKCoordinateSpan span =  {latitudeDelta,longitudeDelta};		///< 经纬度范围
    BMKCoordinateRegion region ;
    region.center = center;
    region.span =span;
    _mapView.region= region;
    _mapView.zoomLevel =  18;
    _mapView.minZoomLevel = 12;
    _mapView.logoPosition  = BMKLogoPositionRightBottom;
    _mapView.buildingsEnabled = YES;
    _mapView.scrollEnabled = YES;
    _mapView.showMapScaleBar = YES;
    _mapView.rotateEnabled = NO;
    //    [_locService startUserLocationService];
    //    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    //    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    // 添加多边形覆盖物
    if (polygon2 == nil) {
        CLLocationCoordinate2D coords[4] = {0};
        coords[0].latitude = 30.705450;
        coords[0].longitude = 114.514871;
        coords[1].latitude = 30.708511;
        coords[1].longitude = 114.514585;
        coords[2].latitude = 30.710288;
        coords[2].longitude = 114.501477;
        coords[3].latitude = 30.707403;
        coords[3].longitude = 114.501540;
        
        polygon2 = [BMKPolygon polygonWithCoordinates:coords count:4];
    }
    [_mapView addOverlay:polygon2];
    
    
    
    if (ground2  ) {
        [_mapView removeOverlay:ground2];
    }
    //    CLLocationCoordinate2D coords[2] = {0};
    //    coords[0].latitude = 30.707432 ;
    //    coords[0].longitude =  114.501577;
    //    coords[1].latitude = 30.708512 ;
    //    coords[1].longitude =  114.514564;
    //    //        coords[0].latitude = 39.910;
    //    //        coords[0].longitude = 116.370;
    //    //        coords[1].latitude = 39.950;
    //    //        coords[1].longitude = 116.430;
    //
    //    BMKCoordinateBounds bound;
    //    bound.southWest = coords[0];
    //    bound.northEast = coords[1];
    //    ground2 = [BMKGroundOverlay groundOverlayWithBounds:bound icon:[[UIImage imageNamed:@"mapDisplay"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //
    //
    CLLocationCoordinate2D coors;
    coors.latitude = 30.707913;
    coors.longitude = 114.508186;
    ground2 = [BMKGroundOverlay groundOverlayWithPosition:coors
                                                zoomLevel:19.1 anchor:CGPointMake(0.52f,0.45f)
                                                     icon:[[UIImage imageNamed:@"mapDisplay.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    ground2.alpha = 1;
    [_mapView addOverlay:ground2];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate =self;
    _geocodesearch.delegate =self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate =nil;
    _geocodesearch.delegate = nil;
}
- (IBAction)startLoc:(UIButton *)sender {
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}
- (IBAction)startFollwHeading:(UIButton *)sender {
    NSLog(@"进入罗盘态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
- (IBAction)startFollowing:(UIButton *)sender {
    NSLog(@"进入跟随态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
- (IBAction)locAndFollow:(UIButton *)sender {
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeHeading;
    _mapView.showsUserLocation = YES;
}

- (IBAction)stopFollowing:(UIButton*)sender {
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    BMKLocationViewDisplayParam  * locationViewDisplayParam = [[BMKLocationViewDisplayParam alloc]init];
    locationViewDisplayParam.isRotateAngleValid = YES;
    
    locationViewDisplayParam.accuracyCircleStrokeColor = [UIColor whiteColor];
    [_mapView updateLocationViewWithParam:locationViewDisplayParam];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (IBAction)Geo:(UIButton *)sender {
    [self.view endEditing:YES];
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= cityT.text;
    geocodeSearchOption.address = addressT.text;
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
    
}

/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"%@",result.address);
    CLLocationCoordinate2D   location = result.location;
    latitudeLabel.text =[NSString stringWithFormat:@"%f",location.latitude];
    longitudeLabel.text = [NSString stringWithFormat:@"%f",location.longitude];
    
    
    
    
    
    if (pointAnnotation  ) {
        
        [_mapView  removeAnnotation:pointAnnotation];
    }
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    
    CLLocationCoordinate2D coor =location;
    coor.latitude = 30.707913;
    coor.longitude = 114.508186;
    //  pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"test";
    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    
    [_mapView addAnnotation:pointAnnotation];
    
    //        CLLocationCoordinate2D coors =location;
    //
    //        BMKGroundOverlay* ground = [BMKGroundOverlay groundOverlayWithPosition:coors
    //    zoomLevel:11 anchor:CGPointMake(0.0f,0.0f) icon:[UIImage imageNamed:@"test.png"]];
    //        [_mapView addOverlay:ground];
    
    
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKGroundOverlay class]]){
        BMKGroundOverlayView* groundView =  [[BMKGroundOverlayView alloc] initWithOverlay:overlay] ;
        return groundView;
    }
    
    if ([overlay isKindOfClass:[BMKPolygon class]]) {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor alloc] initWithRed:0.0 green:0 blue:0.5 alpha:1];
        polygonView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:0.2];
        polygonView.lineWidth =2.0;
        polygonView.lineDash = (overlay == polygon2);
        return polygonView;
        
    }
    
    return nil;
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    if (annotation == pointAnnotation) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            // 设置颜色
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
            // 设置可拖拽
            annotationView.draggable = YES;
        }
        return annotationView;
    }
    return nil;
    //动画annotation
    //    NSString *AnnotationViewID = @"AnimatedAnnotation";
    //    MyAnimatedAnnotationView *annotationView = nil;
    //    if (annotationView == nil) {
    //        annotationView = [[MyAnimatedAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    //    }
    //    NSMutableArray *images = [NSMutableArray array];
    //    for (int i = 1; i < 4; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"poi_%d.png", i]];
    //        [images addObject:image];
    //    }
    //    annotationView.annotationImages = images;
    //    return annotationView;
    
}

#pragma mrak BMKAnnotation
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState fromOldState:(BMKAnnotationViewDragState)oldState{
    pointAnnotation =    view.annotation;
    NSLog(@"%f,%f",pointAnnotation.coordinate.latitude,pointAnnotation.coordinate.longitude);
    NSLog(@"%s",__func__);
}
- (void)dealloc {
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    
    if (_mapView) {
        _mapView = nil;
    }
}

@end
