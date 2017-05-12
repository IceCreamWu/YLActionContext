# YLActionContext
YLActionContext用于实现对象与对象之间**一对一**的简单通信。

# 使用方法
1. 消息接收者注册指定名称的行为（Action），并且需要返回相关信息：

	```
	YLActionContext *kYLActionContext = [YLActionContext actionContext];
	[kYLActionContext registerAction:@"actionName" callback:^id(id data) {
		NSLog(@"%@", data);
		return @"Message From Receiver!";
	} keyObject:self];
	
	```
2. 消息发送者通过指定名称调用Action，可以带上必要的参数：

	```
	id data = [[YLActionContext actionContext] callAction:@"actionName" data:@"Message From Sender!"];
	NSLog(@"%@", data);
	```
	
3. 消息接收者即将销毁时调用解注册方法：
	```
	[[YLActionContext actionContext] unregisterActionWithKeyObject:self];
	```
	

