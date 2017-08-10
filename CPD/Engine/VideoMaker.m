//
//  VideoMaker.m
//  Filmer
//
//  Created by Tauqeer Ahmed on 26/05/2016.
//  Copyright © 2016 Plego. All rights reserved.
//

#import "VideoMaker.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@implementation VideoMaker

+(void)initEmptyAudio:(AVMutableCompositionTrack *) obj{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"emptyAudio" ofType:@"mp3"];
    NSURL*    audio_inputFileUrl = [NSURL fileURLWithPath:path];
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audio_inputFileUrl options:nil];
    CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
    
    [obj insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:CMTimeMake(0,1) error:nil];
}

+ (void) mergeTwoVideosWithFirstFileFromArray:(NSArray *)soureURLs withComplitionHandler:(void(^)(id result))completionHandler withFailueHandler:(void(^)(void))failureHandler
{
    @try {
        
        NSArray* reversedArray = [[soureURLs reverseObjectEnumerator] allObjects];
        soureURLs = reversedArray;
        
        
    AVMutableComposition* composition = [[AVMutableComposition alloc]init];
    AVMutableCompositionTrack* composedTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    AVMutableCompositionTrack *audioTrack;
        
    audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                 preferredTrackID:kCMPersistentTrackID_Invalid];
        
        
    for (AVURLAsset *currentAssetURL in soureURLs)
    {
        [composedTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, currentAssetURL.duration)
                               ofTrack:[[currentAssetURL tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                                atTime:kCMTimeZero error:nil];
        
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, currentAssetURL.duration)
                               ofTrack:[[currentAssetURL tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                                atTime:kCMTimeZero error:nil];
        
        
    }
    
    
    
    NSString* documentsDirectory= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString* myDocumentPath= [documentsDirectory stringByAppendingPathComponent:@"merge_video1.mp4"];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath: myDocumentPath];
    //Check if the file exists then delete the old file to save the merged video file.
    if([[NSFileManager defaultManager]fileExistsAtPath:myDocumentPath])
    {
        [[NSFileManager defaultManager]removeItemAtPath:myDocumentPath error:nil];
    }
    // Create the export session to merge and save the video
    AVAssetExportSession*exporter = [[AVAssetExportSession alloc]initWithAsset:composition presetName:AVAssetExportPresetHighestQuality];
    
    exporter.outputURL=url;
    
    exporter.outputFileType=@"com.apple.quicktime-movie";
    
    exporter.shouldOptimizeForNetworkUse=YES;
    
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        switch([exporter status])
        {
            case AVAssetExportSessionStatusFailed:
                NSLog(@"Failed to export video");
                
                failureHandler();
                
                break;
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"export cancelled");
                break;
            case AVAssetExportSessionStatusCompleted:
                
                
                
                
                if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:url]) {
                    
                    ALAssetsLibrary* library = [[ALAssetsLibrary alloc]init];
                    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error)
                     {
                         NSLog(@"ASSET URL %@",assetURL);
                         
                         
                         
                         if (error)
                         {
                             NSLog(@"EROR %@ ", error);
                         }else{
                             NSLog(@"VIDEO SAVED ");
                             
                             
                             
                             
                             
                             
                             PHAsset* legacyAsset = [PHAsset fetchAssetsWithALAssetURLs:@[assetURL] options:nil].firstObject;
                             
                             
                             [[PHCachingImageManager defaultManager] requestAVAssetForVideo:legacyAsset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info)
                              {
                                  
                                  
                                  
                                  NSLog(@"");
                                  
                                 /* NSURL *fileURL = nil;
                                  __block NSData *assetData = nil;
                                  AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetHighestQuality];
                                  id c = exporter.outputURL;
                                  NSData *tmpFinal = [NSData dataWithContentsOfURL:c];
                                  
                                  
                                 
                                  
                                  completionHandler( @[tmpFinal,asset]);
                                  
                                  //[self uploadChainViedoWithData:tmpFinal];
                                  
                                  */
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                              }];
                             
                             
                             
                             
                             
                             
                             
                             
                         }
                         
                     }];
                    
                    NSLog(@"Video Merge SuccessFullt");
                }
                
                
                
                
                break;
            default:
                
                break;
        }
        
    }];
    }
    
    @catch (NSException *exception) {
        
        
        failureHandler();
        
    }
    
}

- (void)MergeAndSave:(NSArray *)assets
{
    
    AVMutableComposition* mixComposition = [[AVMutableComposition alloc] init];
    
    NSMutableArray *arrayInstruction = [[NSMutableArray alloc] init];
    
    AVMutableVideoCompositionInstruction * MainInstruction =
    [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    AVMutableCompositionTrack *audioTrack;
    
    audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                             preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    
    CALayer *parentLayer;
    CALayer * videoLayer;
    
    CMTime duration = kCMTimeZero;
    for(int i=0;i< [assets count];i++)
    {
        
        
        AVAsset *currentAsset = [assets objectAtIndex:i];
        
        
        AVMutableCompositionTrack *currentTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        
        
        [currentTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, currentAsset.duration) ofTrack:[[currentAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:duration error:nil];
        
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, currentAsset.duration) ofTrack:[[currentAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:duration error:nil];
        
        AVMutableVideoCompositionLayerInstruction *currentAssetLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:currentTrack];
        AVAssetTrack *currentAssetTrack = [[currentAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        UIImageOrientation currentAssetOrientation  = UIImageOrientationUp;
        BOOL  isCurrentAssetPortrait  = NO;
        CGAffineTransform currentTransform = currentAssetTrack.preferredTransform;
        
        if(currentTransform.a == 0 && currentTransform.b == 1.0 && currentTransform.c == -1.0 && currentTransform.d == 0)  {currentAssetOrientation= UIImageOrientationRight; isCurrentAssetPortrait = YES;}
        if(currentTransform.a == 0 && currentTransform.b == -1.0 && currentTransform.c == 1.0 && currentTransform.d == 0)  {currentAssetOrientation =  UIImageOrientationLeft; isCurrentAssetPortrait = YES;}
        if(currentTransform.a == 1.0 && currentTransform.b == 0 && currentTransform.c == 0 && currentTransform.d == 1.0)   {currentAssetOrientation =  UIImageOrientationUp;}
        if(currentTransform.a == -1.0 && currentTransform.b == 0 && currentTransform.c == 0 && currentTransform.d == -1.0) {currentAssetOrientation = UIImageOrientationDown;}
        
        CGFloat FirstAssetScaleToFitRatio = 640.0/640.0;
        
        //768
        if(isCurrentAssetPortrait){
            FirstAssetScaleToFitRatio = 640.0/640.0;
            CGAffineTransform FirstAssetScaleFactor = CGAffineTransformMakeScale(FirstAssetScaleToFitRatio,FirstAssetScaleToFitRatio);
            [currentAssetLayerInstruction setTransform:CGAffineTransformConcat(currentAssetTrack.preferredTransform, FirstAssetScaleFactor) atTime:duration];
        }else{
            CGAffineTransform FirstAssetScaleFactor = CGAffineTransformMakeScale(FirstAssetScaleToFitRatio,FirstAssetScaleToFitRatio);
            [currentAssetLayerInstruction setTransform:CGAffineTransformConcat(CGAffineTransformConcat(currentAssetTrack.preferredTransform, FirstAssetScaleFactor),CGAffineTransformMakeTranslation(0, 0)) atTime:duration];
        }
        
        duration=CMTimeAdd(duration, currentAsset.duration);
        
        [currentAssetLayerInstruction setOpacity:0.0 atTime:duration];
        [arrayInstruction addObject:currentAssetLayerInstruction];
        
        NSLog(@"%lld", duration.value/duration.timescale);
        
        
        
        
        
        parentLayer = [CALayer layer];
        videoLayer  = [CALayer layer];
        
        parentLayer.frame = CGRectMake(0, 0, 640,640);
        
        
        videoLayer.frame = CGRectMake(0, 0, 640, 640);
        
        [parentLayer addSublayer:videoLayer];
        
    }
    
    MainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, duration);
    MainInstruction.layerInstructions = arrayInstruction;
    AVMutableVideoComposition *MainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    MainCompositionInst.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    
    MainCompositionInst.instructions = [NSArray arrayWithObject:MainInstruction];
    MainCompositionInst.frameDuration = CMTimeMake(1, 30);
    MainCompositionInst.renderSize = CGSizeMake(640.0, 640.0);
    
    NSString *myPathDocs =  [[self applicationCacheDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"mergeVideo%-dtemp.mp4",arc4random() % 10000]];
    
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=url;
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
    exporter.videoComposition = MainCompositionInst;
    exporter.shouldOptimizeForNetworkUse = YES;
    [exporter exportAsynchronouslyWithCompletionHandler:^
     {
         switch (exporter.status)
         {
             case AVAssetExportSessionStatusCompleted:
             {
                 NSURL *outputURL = exporter.outputURL;
                 
                 ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                 if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
                     
                     ALAssetsLibrary* library = [[ALAssetsLibrary alloc]init];
                     [library writeVideoAtPathToSavedPhotosAlbum:outputURL completionBlock:^(NSURL *assetURL, NSError *error)
                      {
                          NSLog(@"ASSET URL %@",assetURL);
                          if (error)
                          {
                              NSLog(@"EROR %@ ", error);
                          }else{
                              NSLog(@"VIDEO SAVED ");
                          }
                          
                      }];
                     
                     NSLog(@"Video Merge SuccessFullt");
                     
                 }
             }
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"Failed:%@", exporter.error.description);
                 break;
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"Canceled:%@", exporter.error);
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"Exporting!");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"Waiting");
                 break;
             default:
                 break;
         }
     }];
}

-(NSString *)applicationCacheDirectory
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

@end
