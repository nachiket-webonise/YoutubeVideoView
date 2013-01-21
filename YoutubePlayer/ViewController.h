//
//  ViewController.h
//  YoutubePlayer
//
//  Created by bhuvan khanna on 04/12/12.
//  Copyright (c) 2012 WeboniseLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>
{
    NSString* videoId;
}
@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property (retain, nonatomic) IBOutlet UIWebView *youTubeView;
@property (retain,nonatomic) NSString* videoId;
- (IBAction)onVideoPlay:(id)sender;

-(void)loadHtml;

@end
