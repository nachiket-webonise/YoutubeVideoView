//
//  ViewController.m
//  YoutubePlayer
//
//  Created by bhuvan khanna on 04/12/12.
//  Copyright (c) 2012 WeboniseLab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize videoId;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.youTubeView setDelegate:self];
        // TODO : Remove hardcoded video id
    videoId = @"diP-o_JxysA";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString* requestString = [[request URL]absoluteString];
    NSLog(@"URL Absolute STRING  -- %@",[[request URL]absoluteString]);
    
    /*URL Absolute STRING  -- http://www.youtube.com/embed/0nR9JS2WsNg?enablejsapi=1*/
    /*URL Absolute STRING  -- video:onYouTubePlayerAPIReady*/
    
//    NSString* urlScheme = [[request URL]scheme];

    /* TEST CODE.  Get the video id*/
    
    /*
    if([urlScheme isEqualToString:@"http"]){
        NSString* youtubeUrl = @"http://www.youtube.com/embed/";
        NSString* subString = [requestString substringFromIndex:NSMaxRange([requestString rangeOfString:youtubeUrl])];
        NSLog(@"SUBSTRING -- %@",subString);
        NSString* questionMark = @"?";
        
        NSRange range = [subString rangeOfString:questionMark];
        NSString* string = [subString substringToIndex:range.location];
        NSLog(@"VIDEO ID  -- %@",string);
        
    }
     */
    
    /*Handle callbacks from javascript in the youTubeHtml.html page*/
    
    if([requestString isEqualToString:@"video:ended"]){
        NSLog(@"!!!! Video end");
        /*Reload the page so that we don't see the related youtube videos.*/
        [webView reload];
        return NO;
    }else if([requestString isEqualToString:@"video:onYouTubePlayerAPIReady"]) {
        NSLog(@" !!!!! video:onYouTubePlayerAPIReady");
        return NO;
    } else if ([requestString isEqualToString:@"video:didSetId"]){
        NSLog(@" !!!!! video:didSetId");
        return NO;
    } else if([requestString isEqualToString:@"video:getId"]){
        /*Set the video Id by calling the javascript setVideoId function. */
        NSString* jsFunction = [ NSString stringWithFormat:@"setVideoId(\'%@\')",videoId];
        [self.youTubeView stringByEvaluatingJavaScriptFromString:jsFunction];
        return NO;
    } else if ([requestString isEqualToString:@"video:error"]){
        NSLog(@"!!!!! Error playing video");
        return NO;
    } else if ([requestString isEqualToString:@"video:buffering"]){
        NSLog(@"!!!!!! Video buffering");
        return NO;
    } else if ([requestString isEqualToString:@"video:cued"]){
        NSLog(@"!!!!!! Video cued");
        return NO;
    }
    /*else if ([requestString isEqualToString:@"video:paused"]){
        NSLog(@"!!!!!! Video paused");
        return NO;
    } else if ([requestString isEqualToString:@"video:playing"]){
        NSLog(@"!!!!!! Video playing");
        return NO;
    } else if([requestString isEqualToString:@"video:unstarted"]){
        NSLog(@"!!!!! Video Unstarted");
//        [webView reload];
        return NO;
    }
     */
    return YES;
}

-(void)loadHtml {
        // load the HTML file
        //http://www.youtube.com/embed/aSHJcQhYsSQ?enablejsapi=1
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"youTubeHtml" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path isDirectory:NO];
        //NSURL* url1 = [NSURL URLWithString:@"http://www.youtube.com/embed/aSHJcQhYsSQ?enablejsapi=1"];
//cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url1];
    [self.youTubeView loadRequest:request];
    
//    [self.youTubeView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)dealloc {
    [_playButton release];
    [_youTubeView release];
    [super dealloc];
}
- (IBAction)onVideoPlay:(id)sender {
    [self loadHtml];
}
@end
