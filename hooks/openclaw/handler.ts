import type { HookContext, MessageReceivedEvent } from "@openclaw/sdk";

/**
 * MyKnowledge Hook Handler
 * 
 * 自动检测复杂任务并创建知识库记录
 */

export default async function handler(ctx: HookContext<MessageReceivedEvent>) {
  const { message } = ctx.event;
  
  // 只处理用户消息
  if (message.role !== "user") {
    return;
  }
  
  // 分析任务复杂度
  const isComplex = analyzeComplexity(message.content);
  
  if (isComplex) {
    // 调用 MyKnowledge 自动创建
    try {
      await ctx.agent.execute("myknowledge", {
        action: "auto_create",
        content: message.content,
        timestamp: new Date().toISOString()
      });
      
      // 可选：记录日志
      console.log("[MyKnowledge Hook] 自动创建知识库记录");
    } catch (error) {
      console.error("[MyKnowledge Hook] 自动创建失败:", error);
    }
  }
}

/**
 * 分析任务复杂度
 * 
 * 检测关键词数量，判断是否为复杂任务
 */
function analyzeComplexity(content: string): boolean {
  const keywords = [
    "分析", "统计", "挖掘",
    "开发", "设计", "调研",
    "整理", "清洗", "项目",
    "系统", "工具", "功能"
  ];
  
  const count = keywords.filter(kw => content.includes(kw)).length;
  
  // 匹配 2 个及以上关键词视为复杂任务
  return count >= 2;
}

/**
 * 生成项目/需求名称
 */
function generateProjectName(content: string): string {
  // 提取前 20 个字符作为临时名称
  const name = content.slice(0, 20).trim();
  return name || "未命名任务";
}
